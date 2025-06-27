function [T_CTD, C_CTD, C_CTD_match, S_CTD, T_CTD_match, potential_density, P_slow] = offsets_CTD(Data,information)

%load("DAT_041.mat")
% ql_info=quick_look;
load(Data)
ql_info=information;

profile = get_profile(P_slow, W_slow, ql_info.profile_min_P, ...
            ql_info.profile_min_W, 'down', ...
            ql_info.profile_min_duration, fs_slow);
start_index_slow = profile(1, ql_info.profile_num);
end_index_slow = profile(2, ql_info.profile_num);
m = (start_index_slow : end_index_slow)';


% - All variables
S = whos; 
% - Get sizes and indices
% - Get sizes and indices
junk = zeros(size(S,1),2);
for k = 1:size(S,1)
    junk(k,:) = S(k).size; % Get the size of every variable
end

index_slow = find((junk(:,1) == size(t_slow,1)) & junk(:,2) == 1); % index_slow points to the slow channels.

for k = 1:size(index_slow,1)
    slow_name = S(index_slow(k)).name;
    eval([slow_name '=' S(index_slow(k)).name '(m);'] ); % trim to m
end

clear junk
%-----------------------------------------------------------------
% ----- Calculate profile-specific estimate of the fall rate -----
%-----------------------------------------------------------------
% The variable 'W_slow' is heavily biased by the zero speed after the 
% profile. It was calculated using a 4th order zero-phase filter that 
% "sees" the stop after the profile. Here W_slow is only estimated 
% from the data for the requested profile.
% -------------------------------------------------------------------
fc = 0.5;
[b,a]=butter(4,fc/(fs_slow/2));
dP_dt = gradient(P_slow,1/fs_slow);
dP_dt_LP = filtfilt(b,a,dP_dt);
mean_speed = mean(speed_slow);
T_CTD = JAC_T;
C_CTD = JAC_C;
[C_CTD,~] = despik(C_CTD,5,ql_info);
[S_CTD, C_CTD_match, T_CTD_match] = salinity_JAC (P_slow, T_CTD, C_CTD,...
                          'fs',fs_slow,'speed',mean_speed);
potential_T = theta(S_CTD, T_CTD, P_slow, 0); %pot_T relative to P=0;
potential_density = sigma_p(potential_T, S_CTD, 0); % relative to P=0

end