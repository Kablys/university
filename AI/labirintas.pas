program LABIRINTAS;

uses sysutils, Crt;

var LAB : array[1..20, 1..20] of integer;
 CX, CY : array[1..4] of integer;
 L,
 X, Y,
 I, J,
 M, N,
 BANDSK : integer;
 YRA : boolean;
 input : TextFile;
 failas : string;
 notOK : boolean;

procedure EITI(X, Y : integer; var YRA : boolean);
 var K, {Einamosios produkcijos numeris}
 U, V : integer; {Nauja pad?tis pritaikius produkcij?}
begin {EITI}
  if (X = 1) or (X = M) or (Y = 1) or (Y = N)then
    YRA := true {TERM(DATA) = true, jeigu kra?tas}
    else
        begin
            K := 0;
            repeat
                K := K + 1; {Imama kita produkcija. Ciklas per produkcijas}
                U := X + CX[K]; V := Y + CY[K]; {Nauja agento pad?tis}
                BANDSK := BANDSK+1;
                if LAB[U, V] = 0 then
                   begin
                       L := L + 1; LAB[U,V] := L;
                       if BANDSK>9 then write(BANDSK,') ')
                       else write(BANDSK,')  ');
                       for J := 1 to L-3 do write('.');
                       writeln('R',K,' L=',L,' X=', U,' Y=', V, ' Laisva');
                       EITI(U, V, YRA); {Rekursyvus kvietimas keliauti toliau}
                       if not YRA then
                            begin
                                LAB[U,V] := -1; {0 BACKTRACK atveju}
                                L := L - 1;
                            end;
                   end
                else
                    begin
                        if BANDSK>9 then write(BANDSK,') ')
                        else write(BANDSK,')  ');
                        for J := 1 to L-2 do write('.');
                        writeln('R',K,' L=',L+1,' X=', U,' Y=', V, ' Siena');
                    end;
            until YRA or (K = 4);
        end;
end; {EITI}

begin
 notOK := True;
 while notOK do
    begin
        notOK := False;
        writeln('Nurodykite labirinto faila:');
        readln(failas);
        assign(input,failas);
        if not FileExists(failas) then
            begin
                writeln('failas nerastas');
                notOk := True;
                continue;
            end;
        reset(input);
        readln(input,M,N);
        if (M > 20) or (N > 20) then
            begin
                notOK := True;
                writeln('netinkamo dydzio lenta, pakeisti faila' );
            end;
     end;

 for J := N downto 1 do
    begin
        for I := 1 to M do read(input,LAB[I,J]);
    end;

 close(input);

 notOk := True;
 while notOK do
    begin
        notOK := False;
        writeln('iveskite pradine padeti');
        read(X, Y);
        if (X > M) or (Y > N) then
            begin
                notOK := True;
                writeln('per dideles pradines busenos koordinates' );
            end
        else if LAB[X,Y] = 1 then
                begin
                    writeln('Pradine padetis ant sienos');
                    notOK := True;
                end;
    end;
 L := 2; LAB[X,Y] := L;
 writeln();
 writeln('0)  pradine padetis L = ',L,' X = ',X,' Y = ',Y);

 CX[1] := -1; CY[1] := 0;
 CX[2] := 0; CY[2] := -1;
 CX[3] := 1; CY[3] := 0;
 CX[4] := 0; CY[4] := 1;

 YRA := false; BANDSK := 0;

 EITI(X, Y, YRA);
 if YRA
    then
        begin
            writeln();
            writeln('Kelias egzistuoja');
            writeln();
            for J := N downto 1 do
                begin
                    if J > 9 then write(J,'.  ')
                    else write(J,'.   ');
                    for I := 1 to M do
                        begin
									if LAB[I,J] = 1
										then TextBackground(White)  
									else if LAB[I,J] = 2
										then TextBackground(Green)  
									else if LAB[I,J] < 1
										then TextBackground(Red)  
									else TextBackground(Black);
                            if (LAB[I,J] = -1) or ( (9 < LAB[I,J]) and (LAB[I,J] < 100) ) then
                                begin
                                    write(LAB[I,J]);
                                    write('  ');
                                end
                            else if LAB[I,J]>99 then 
								begin
									write(LAB[I,J],' ')
								end
                                 else write(LAB[I,J],'   ');
                        end;
					TextBackground(Black);
                    writeln();
                end;
			writeln();
            write('    ');

            write(' ');
            for J := 1 to M do if J > 9 then write(J,'. ')
                else write(J,'.  ');
        end
    else writeln('Kelias neegzistuoja');

 readln;
 readln;
end.
