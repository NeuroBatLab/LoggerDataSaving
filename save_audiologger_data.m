function save_audiologger_data

ALString = 'AUDIOLOG';
base_dir = []; % base saving directory
date_str_format = 'mmddyyyy';
dateStr = datestr(date,date_str_format); % date string for saving
script_dir = []; % location of .bat file 
status = dos([script_dir 'list_drive_letters.bat']);
if status
    disp('error getting drive names')
    return
end

fid = fopen([script_dir 'drivenames.txt']);
driveNames = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
driveNames = driveNames{1}(~cellfun(@isempty,driveNames{1}));

idx = find(cellfun(@(x) ~isempty(strfind(x,'--')),driveNames));
nDrive = idx - 1;

driveLetters = driveNames(1:nDrive);
driveLabels = driveNames(idx+1:idx+nDrive);

audio_drive_idx = cellfun(@(x) ~isempty(strfind(x,ALString)),driveLabels);
ALLabel = driveLabels{audio_drive_idx};
ALNumber = str2num(ALLabel(strfind(ALLabel,ALString)+length(ALString):end));

AL_base_dir = [base_dir dateStr filesep 'audiologgers' filesep]; % directory for saving today's data

if ~exist(AL_base_dir,'dir')
    mkdir(AL_base_dir)
end

AL_data_dir = [AL_base_dir 'logger' num2str(ALNumber) filesep];
if ~exist(AL_data_dir,'dir')
    mkdir(AL_data_dir)
    AL_drive_dir = [strtrim(driveLetters{audio_drive_idx}) filesep];
    disp(['Copying file from from audiologger #' num2str(ALNumber) ' ...']);
    status = copyfile([AL_drive_dir '*'],AL_data_dir);
    if status
        disp(['Files copied successfully from audiologger #' num2str(ALNumber)])
    else
        disp(['Failed to copy files from audiologger #' num2str(ALNumber)])
    end
else
    disp('Audio logger directory already exists')
    return
end

fclose('all');

end







