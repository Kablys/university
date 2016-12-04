%% pratybos000.m

x = randn(1,1000);
% arba load data_file

figure(1);plot(cumsum(x));

%% du grafikai

x = cumsum(randn(1,1000));
y = cumsum(randn(1,1000));
figure(1);plot([x;y]');

%% kitaip

figure(2);hold on; plot(x);plot(y,'r:');
%% load daily data
d1 = read_ts_OHLCV('a_OHLCV_@FDAX.csv');

%% plot daily data
figure(1);plot(d1.date,d1.close);datetick;grid on;
