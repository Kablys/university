%% depfun pratybos002
%% load daily data
d1 = read_ts_OHLCV('a_OHLCV_EURUSD.csv');

%% plot it
figure(1);plot(d1.date,d1.close);datetick;grid on;
title('EURUSD daily data');xlabel('time');ylabel('price');


%% plot 2ma
figure(2);clf;plot(d1.date,d1.close);datetick;grid on;
title('EURUSD daily data');xlabel('time');ylabel('price');

ma1 = mavg(d1.close,21);
ma1(1:20) = NaN; %prevent displaying initial bit of data
hold on;plot(d1.date,ma1,'r');axis tight;

ma2 = mavg(d1.close,201);
ma2(1:200) = NaN; 
hold on;plot(d1.date,ma2,'g');axis tight;

legend({'price','21d mavg','201d mstd'});

%% plot mstd

figure(3);clf;subplot(3,1,[1 2]);
plot(d1.date,d1.close);datetick;grid on;
title('EURUSD daily data');xlabel('time');ylabel('price');

subplot(3,1,[3]);
s = mstd(d1.close,200,1);
plot(d1.date,s);datetick;grid on;
xlabel('time');ylabel('200 day STD');

%% next 
d2 = get_gf_histdata('AAPL','start','29-Sep-1990');%,'29-Sep-2010');
d2.ddate = datenum(d2.date);
figure(4);plot(d2.ddate,d2.close);datetick; grid on;

