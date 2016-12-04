

%%Get tick data
d0 = read_ts_OHLCVtick('US2.AAPL_160928_160928.csv');

%%Get min data
d1 = read_ts_OHLCV('US2.AAPL_150929_160929.csv');

%%Get day data
d2 = read_ts_OHLCVday('US2.AAPL_150929_160929.csv');

%Plot all
figure(1);
subplot(3,1,1);
%[last, date] = unique([d0.date, d0.last]);
scatter(d0.date,d0.last,'b',".");
title('Tick plot');xlabel('Time');ylabel('Last price');
datetick;grid on;

subplot(3,1,2);
plot(d1.date,d1.close);
title('Minute plot');xlabel('Time');ylabel('Closing price');
datetick;grid on;

subplot(3,1,3);
plot(d2.date,d2.close);
title('Day plot');xlabel('Time');ylabel('Closing price');
datetick;grid on;

%%Plot random
startDate = datenum('19-May-2001','dd-mmm-yyyy');
date = cumsum(randi(10,1,1000)) +startDate;
size = cumsum(randn(1,1000));

figure(2);plot(date,size);
datetick;
grid on;

datestr((sort(d1.date(2:end) - d1.date(1:end-1)))(end-10:end),'dd, HH:MM:SS')