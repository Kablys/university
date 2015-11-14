import java.io.*;
import java.net.*;
import java.util.Scanner;

// ALT+ENTER keicia i siuloma reiksme
// CTRL+P rodo metodo parametrus
// CTRL+Q uzedus ant klases ar metodo, rodo java doca
// CTRL+CLICK ant klases nueina i jos source'a

public class IrcClient {

    private BufferedReader reader;
    private BufferedWriter writer;
    private Socket socket;
    private Scanner scanner;

    private Thread readingJob = new Thread() {
        @Override
        public void run() {
            try {
                String buffer;
                // Keep reading lines from the server.
                while ((buffer = reader.readLine()) != null) {
                        if (buffer.startsWith("PING ")) {
                            System.out.println("Got pinged!");
                            try {
                                // We must respond to PINGs to avoid being disconnected.
                                writer.write("PONG " + buffer.substring(5) + "\r\n");
                                writer.flush();
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        } else {
                        // Print the raw line received by the bot.
                        System.out.println(buffer);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    };

    public static void main(String[] args) throws Exception {
        if (args.length != 4) {
            System.err.println("Not right amount of arguments");
            System.err.println("IrcClient server nickname username channel");
            //throw new IllegalArgumentException("Not enough arguments");
        }
        new IrcClient(args[0], args[1], args[2], args[3]);
    }

    public IrcClient(String server, String nick, String login, String channel) throws IOException, InterruptedException {
        // Connect
        socket = new Socket(server, 6667);//6667 standartinis irc portas
        reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream( )));

        // Writer login
        login(nick, login);

        // Check if logged on via reader
        if (isLogonSuccessful()) {
            System.out.println("Logged in!");
        } else {
            System.err.println("Logon failed!");
            return;
        }

        // Start reader on another thread
        readingJob.start();

        join(channel);

        // Start writer on another thread
        scanner = new Scanner(System.in);
        String buffer;
        while ((buffer = scanner.nextLine()) != null) {
            if (buffer.charAt(0) == '/') {
                int spaceIndex = buffer.indexOf(' ');
                String cmd;
                if (spaceIndex < 1) {
                    cmd = buffer.substring(1);
                } else {
                    cmd = buffer.substring(1, spaceIndex);
                }
                cmd = cmd.toUpperCase();

                if (cmd.equals(("QUIT"))) {
                    quit();
                    return;
                } else {
                    String params = buffer.substring(spaceIndex + 1);
                    writer.write(String.format("%s %s\r\n", cmd, params));
                    writer.flush();
                }
            } else {
                writer.write("PRIVMSG " + channel + " :" + buffer + "\r\n");
                writer.flush();
            }
        }
    }

    public void quit() throws IOException, InterruptedException {
        socket.shutdownInput();
        // Interrupt thread
        readingJob.interrupt();
        // Join threads and wait until readingJob exits
        readingJob.join();
        // Invoke quit command
        writer.write("QUIT\r\n");
        // Close buffers
        writer.close();
        reader.close();
        // Close scanner
        scanner.close();
        socket.close();
    }

    public void join(String channel) throws IOException {
        writer.write("JOIN " + channel + "\r\n");
        writer.flush( );
    }

    public void login(String nick, String login) throws IOException {
        // Log on
        writer.write("NICK " + nick + "\r\n");
        writer.write("USER " + login + " 0 * : Java IRC Hacks Bot\r\n");
        writer.flush();
    }

    public boolean isLogonSuccessful() throws IOException {
        String buffer;
        while ((buffer = reader.readLine( )) != null) {
            if (buffer.contains("004")) {
                // We are now logged in.
                return true;
            }
            else if (buffer.contains("432")) {
                System.err.println("Nickname is not allowed.");
                return false;
            }
            else if (buffer.contains("433")) {
                System.err.println("Nickname is already in use.");
                return false;
            }
        }
        System.err.println(buffer);
        return false;
    }



}
