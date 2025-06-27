function [dv,spike,dv_LP,dv_HP] = single_despike_(dv, thresh, smooth, Fs, N)
        
        %N = N / 2;
        
        % Force into a column vector if required
        dv = dv(:);
        % Zero padding alleviates problems when spikes are at the
        % beginning or the end of the vector, and avoids problems
        % caused by filter transients of the smoothing filter
        % and rectifying filters. (Fab)
        len = length(dv);
        padLen = min(length(dv), 2*floor(Fs/smooth));    % padLen must not exceed the length of the input vector
        range = (1+padLen):(len+padLen); % these two values mark the start and end of the input
        % vector in the padded vector (used later)
        
        dv = [flipud(dv(1:padLen)); dv; flipud(dv(len-padLen+1:len))];
        
        % high pass filter & rectify
        [b,a] = butter(1, (1/20)/(1/2*Fs), 'high');
        dv_HP = abs(filtfilt(b,a, dv));
        
        % smoothing coefficients
        [b_LP,a_LP] = butter(1, smooth/(Fs/2));
        
        % find spikes
        s = warning; % cache warning state
        warning off  % avoid divide-by-zero warnings (fab)
        dv_LP = filtfilt(b_LP,a_LP,dv_HP);

        %dv_LPt=gradient(dv_LP);
        %dv_HPt=gradient(dv_HP);
        ratio= abs(dv_HP) ./ abs(dv_LP);
        spike = find( ratio > thresh);
        %spike = find(abs(dv_HP-dv_LP)./abs(dv_HP+dv_LP) > thresh);
        warning(s);  % reset warning state
        
        % Save interm variables for generating plots.
        dv_LP = dv_LP(range);
        dv_HP = dv_HP(range);
        
        % ignore spikes detected in the padding
        spike(spike<range(1) | spike>range(end)) = [];
        
        if isempty(spike) % get out if no spikes are found (RGL)
            dv = dv(range);   % remove the padding
            return
        end
        
        good_points = true(size(dv));
        %R = 11;
        R = round(Fs /(4*smooth)); % arbitrarily decided by Rolf 2015-11-04
        %R = round(Fs/35);  % R for REGION - area size to average when calculating
        % replacement values. Calculated from the sampling rate.
        
        %%%% First pass, mark invalid data.
        for s = spike'
            idx = round( max(1,s-N) : min(length(good_points),s+N) );
            good_points(idx) = false;
        end
        
        
        %%%% Second pass, find start / stop points.
        start_points = find(diff([true; good_points]) == -1);
        end_points   = find(diff(good_points) == 1);
        start_stop = [start_points end_points];
        
        
        %%%% Third pass, calculate and replace bad points.
        for index = start_stop'
            start = index(1);
            stop  = index(2);
            
            % Find points within region R that are valid and use to
            % calcualte the start value.
            idx = max(start-R,1):start-1;
            points = dv( find(good_points(idx)) + idx(1) - 1 );
            start_value = sum(points) / length(points);
            
            % Find points within region R that are valid and use to
            % calcualte the last value.
            idx = start+1 : min(start+R,length(good_points));
            points = dv( find(good_points(idx)) + idx(1) - 1 );
            stop_value = sum(points) / length(points);
            %keyboard
            dv(start:stop) = (start_value + stop_value) / 2;
           
            
        end
        
        
        % remove the padding
        dv = dv(range);
        spike = spike - padLen;
end
