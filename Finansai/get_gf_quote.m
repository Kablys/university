% Get quote from Google finance
% The function is a really dumb way of obtaining quote from google finance.
% Iam sure there's a smart way but I needed something right now so I wrote
% this quote
%
% FUNCTION QUOTE = GET_GF_QUOTE(STOCK_SYMBOL,params....)
% The function GET_GF_QUOTE extracts quote from the buffer obtained through
% google finance website. The website can be changed through input
% parameters
%
% Input:
% STOCK_SYMBOL : A string representing
% PARAMS:
% 'detailed'
%           Obtains detailed quote info such as company_id,
%           after_market...etc...
% 'aftermarket'
%           Obtains aftermarket data
%
%
% Output:
%
% Example Usage:
% googQuote = get_gf_quote('GOOG');
% geQuote = get_gf_quote('ge','detailed');
% 
% Copyright by NEO672, Concept 7 Intelligencies.
% Date: May 2nd 2008. The 4th day I started options 

function symb = get_gf_quote(stck,varargin)

                %% DEFAULTS
symb.quote=-1;
count=0;
try_company_id = false;
found_market_data = false;
after_market = false;
quick_quote = true; %bydefault obtains quick quote
found_quote = false;
detailed_quote = false;

        %   Symbol vals Defaults    %
symb.companyId = -1;
symb.dayOpen = -1;
symb.dayClose = -1;
symb.mktCap = '';
symb.dayHigh = -1;
symb.dayLow = -1;
symb.yrHigh = -1;
symb.yrLow = -1;

        %   Reference Strings Defaults %
ref_strings.mrktdata = '<!-- MARKET DATA -->';
ref_strings.dayopen = 'class=key>Open';
ref_strings.val = 'class=val>';
ref_strings.mktcap  = 'class=key>Mkt Cap:';
ref_strings.website = 'http://www.google.com/finance?q=';
ref_strings.dayhigh = 'class=key>High';
ref_strings.daylow = 'class=key>Low';
ref_strings.yrhigh = 'class=key>52Wk High';
ref_strings.yrlow = 'class=key>52Wk Low';
ref_strings.yield = 'class=key>Yield';
ref_strings.shares = 'class=key>Shares';
ref_strings.volume = 'class=key>Volume';

ref_strings.pe = 'class=key>P/E:';
ref_strings.companyId = '_companyId';
                %% PROCESSING
if(nargin>1)
    for i=1:nargin-1
        param = varargin{i};
        switch(param)
            case 'detailed'
                detailed_quote  = true;
                quick_quote = false;
            case 'aftermarket'
        end
    end
end

%if quick_quote is true
if(quick_quote)
    %Get data from google finance
    fprintf(1,'Obtaining Google finance quote for %s...', stck);
    urlStr = strcat(ref_strings.website,stck);
    java_url     = java.net.URL(urlStr);
    stream       = openStream(java_url);
    ireader     = java.io.InputStreamReader(stream );
    breader      = java.io.BufferedReader(ireader);
    while(true)
        if(count>=30000)
            disp('Could not find quote in first 3000 lines');
            try_company_id = true;
            break;
        end
        line_buff = char(readLine(breader));
        if(~isempty(strfind(line_buff,'lastTrade')))
            quote_line = char(readLine(breader));
            pos = strfind(quote_line,'_l">');
            if(~isempty(pos))   
                quote_val = str2double(deblank(quote_line(strfind...
                    (quote_line,'_l">')+4:strfind(quote_line,'</')-1)));
                if(isnumeric(quote_val))
                    disp('found quote value!! ::')
                    symb.quote=quote_val;
                    found_quote=true;
                    break
                else
%                     error ('Invalid quote format in obtained source buffer');
                end                
            end
        end
       count = count+1; 
    end
end
%Get detailed quote
if(detailed_quote)
    %Get data from google finance
    fprintf(1,'Obtaining Google finance quote for %s...', stck);
    urlStr = strcat(ref_strings.website,stck);
    java_url     = java.net.URL(urlStr);
    stream       = openStream(java_url);
    ireader     = java.io.InputStreamReader(stream );
    breader      = java.io.BufferedReader(ireader);
    global CNT
    CNT = 0;
    cmpnyid_qt_str = '';cmpnyid_qt_aftrmrkt_str='';
    while(true)        
        line_buff = char(readLine(breader));    
                %Get day open value
        if(~isempty(strfind(line_buff,ref_strings.dayopen)))
            tmp = getVal(ref_strings.val,breader);
            if(~isempty(tmp))
                symb.dayOpen = str2num(tmp);
            end
        end
                %Get day high
        if(~isempty(strfind(line_buff,ref_strings.dayhigh)))
            tmp = getVal(ref_strings.val,breader);
                        if(~isempty(tmp))
                symb.dayHigh = str2num(tmp);
            end
        end
                %Get market capital     
        if(~isempty(strfind(line_buff,ref_strings.mktcap)))
        tmp = getVal(ref_strings.val,breader);
%         if(~isempty(tmp))
                symb.mktCap = tmp;
%             end
        end
                % Get Day Low
        if(~isempty(strfind(line_buff,ref_strings.daylow)))
            tmp = getVal(ref_strings.val,breader); 
            if(~isempty(tmp))
                symb.dayLow = str2num(tmp);
            end
        end
                % Get year high
        if(~isempty(strfind(line_buff,ref_strings.yrhigh)))
           tmp = getVal(ref_strings.val,breader); 
            if(~isempty(tmp))
                symb.yrHigh = str2num(tmp);
            end
        end
                % Get Year Low
        if(~isempty(strfind(line_buff,ref_strings.yrlow)))
            tmp = getVal(ref_strings.val,breader); 
            if(~isempty(tmp))
                symb.yrLow = str2num(tmp);
            end
        end
                % Get Yield
        if(~isempty(strfind(line_buff,ref_strings.yield)))
            tmp = getVal(ref_strings.val,breader); 
            if(~isempty(tmp))
                symb.yild = tmp;
            end 
        end
                % Get Shares
        if(~isempty(strfind(line_buff,ref_strings.shares)))
            tmp = getVal(ref_strings.val,breader); 
            if(~isempty(tmp))
                symb.shares = tmp;
            end
        end
                % Get Volume
        if(~isempty(strfind(line_buff,ref_strings.volume)))
            symb.volume = getVal(ref_strings.val,breader);
        end
        %Get Company ID
        if(~isempty(strfind(line_buff,ref_strings.companyId)))
            tmp = str2num(deblank(line_buff(strfind(line_buff,'=')+1:end)));
            if(isnumeric(tmp))
                symb.companyId = tmp;
                cmpnyid_qt_str = strcat(num2str(symb.companyId),'_l">');
                cmpnyid_qt_aftrmrkt_str = strcat(num2str(symb.companyId),'_el">');
            end
        end
        %Get last trade using company ID
        if(~isempty(cmpnyid_qt_str))
            if(~isempty(strfind(line_buff,cmpnyid_qt_str)));
                bgn = strfind(line_buff,'">')+2;
                lst = strfind(line_buff,'</')-1;
                symb.quote = str2double(deblank(line_buff(bgn:lst)));
            end
        end
        %get after hours quote
        if(~isempty(cmpnyid_qt_aftrmrkt_str))
            if(~isempty(strfind(line_buff,cmpnyid_qt_aftrmrkt_str)));
                bgn = strfind(line_buff,'">')+2;
                lst = strfind(line_buff,'</')-1;
                symb.aftermarketQuote = str2double(deblank(line_buff(bgn:lst)));
            end
        end
        
        CNT = CNT+1;
        if(CNT==2000)
            break;
        end
    end
end

if(try_company_id)
    %Get data from google finance
    fprintf(1,'Obtaining Google finance quote for %s...', stck);
    urlStr = strcat(ref_strings.website,stck);
    java_url     = java.net.URL(urlStr);
    stream       = openStream(java_url);
    ireader     = java.io.InputStreamReader(stream );
    breader      = java.io.BufferedReader(ireader);
    %Read buffer to obtain stock data
    count = 0;
    while(true)
        count = count+1;
        line_buff = char(readLine(breader));
        if(~isempty(strfind(line_buff,ref_strings.companyId)))
            company_id = str2num(deblank(line_buff(strfind(line_buff,'=')+1:end)));
            if(~isnumeric(company_id))
%                 error('Could not find conpany ID. Maybe the stock symbol is not defined or predefined syntax for finding company_id');
            else
                disp('Found Company ID!!!... Should retrieve quote in a couple of secs...');
                reference_str = strcat(num2str(company_id),'_l">');
                while(true)
                    line_buff = char(readLine(breader));
                    pos = strfind(line_buff,reference_str);
                    if(~isempty(pos))
                        bgn = strfind(line_buff,'">')+2;
                        lst = strfind(line_buff,'</')-1;
                        symb.quote = str2double(deblank(line_buff(bgn:lst)));
                        %get market quote
                        found_market_data = true;
                        break
                    end
                    if(after_market)
                        %Try for after market quote
                        break;
                    end
                end
                break;
            end
        end
        if(count>3000)
            disp('Could not find with alternate method');
            break;
        end
    end
end

if(~found_market_data)

end
end
function rslt = getVal(refstr,breader)
global CNT
rslt = [];
    while(true)
        line_buff = char(readLine(breader));
        if(~isempty(strfind(line_buff,refstr)))
            rslt = line_buff(strfind(line_buff,refstr)+length(refstr):end);
            break;
        end
        CNT = CNT+1;
        if(CNT==2000)
            break;
        end
    end
end