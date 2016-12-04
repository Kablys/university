%% load daily data
d1 = read_ts_OHLCV('a_OHLCV_@FDAX.csv');

%% plot daily data
figure(1);plot(d1.date,d1.close);datetick;grid on;

%% load minute data
d = read_ts_OHLCV('a_OHLCV_AA.csv');

%% display minute data
all_dates = unique(floor(d.date));
the_date = all_dates(end-3);
% idx stores desired values for plotting
idx = floor(d.date) == the_date; % datenum(2010,08,07);
disp({'info for:' datestr(the_date)});
disp({'number of data points will be plotted',sum(idx)});
figure(2);plot(d.date(idx),d.close(idx));datetick; grid on; 
title(['closing prices, date:' datestr(the_date)]);
figure(3);plot(d.date(idx),d.volume(idx));datetick; grid on; 
title(['trading volume, date:' datestr(the_date)]);

%% plot candles
time = d.date - floor(d.date);
idx = floor(d.date) == datenum(2010,07,07);
O=d.open(idx);
H=d.high(idx);
L=d.low(idx);
C=d.close(idx);
figure(4);cndl(H,L,O,C);grid on;

%% plot candles 2
idx = d1.date > datenum(2010,01,01);
O=d1.open(idx);
H=d1.high(idx);
L=d1.low(idx);
C=d1.close(idx);
figure(5);clf;cndl(H,L,O,C);grid on;title('candle plot')

%% depfun pamoka001
