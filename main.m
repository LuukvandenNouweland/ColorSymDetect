clc; clear all; close all; warning off;
%%
restoredefaultpath;
addpath(genpath(fullfile('.','libs')));
%%
srcDir = './../template/temp';
filePattern = fullfile(myFolder, '*.png');
theFiles = dir(filePattern);
% https://matlab.fandom.com/wiki/FAQ#How_can_I_process_a_sequence_of_files.3F
for k = 1 : length(theFiles)
    file = theFiles(k).name;;
    %%
    [~,name,~] = fileparts(file);
    img = imread([srcDir '/' file]);
    img = imresize(img,0.25);
    disp(['Processing : ' name]);
    tic;
    [SymOcLgHSV,voteMap] = symBilOurCentLogGaborHSV(img);
    toc;
    %%
    Num = 5;

    MarkerEdgeColors=hsv(Num);
    str = {};
    mkSize = 10;
    lnWidth = 2;

    figure;
    imshow(img); hold on;
    for j=1:min(Num,size(SymOcLgHSV,1))
        X = [SymOcLgHSV(j,1) SymOcLgHSV(j,3)];
        Y = [SymOcLgHSV(j,2) SymOcLgHSV(j,4)];
        plot(X,Y, '-s','Color',MarkerEdgeColors(j,:),...
                'MarkerSize',mkSize,'LineWidth',lnWidth);
        str{j} = [num2str(j) ' - ' num2str(SymOcLgHSV(j,5))];
    end
    legend(str,'Location','BestOutside');
    hold off;
    %%
    figure,imagesc(voteMap); colormap('jet'); axis off;
end