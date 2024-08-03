[file, path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'}, 'Choose Your Plate !');
plate =[path,file];
picture = imread(plate);
picture=imresize(picture,[300 500]);
picture = rgb2gray(picture);
threshold = graythresh(picture);
picture = ~imbinarize(picture, threshold-0.1);

picture = bwareaopen(picture, 500);
background = bwareaopen(picture, 10000);

picture = picture - background;

imshow(picture);

imshow(picture)
[L,Ne]=bwlabel(picture);
propied=regionprops(L,'BoundingBox');
hold on
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

load mapsetfa;
totalLetters=size(MAPFA,2);
final_output=[];
t=[];
for n=1:Ne
    [r,c]=find(L==n);
    Y=picture(min(r):max(r),min(c):max(c));
    ro=zeros(1,totalLetters);
    for k=1: totalLetters   
        [row, col] = size(MAPFA{1,k});
        Y = imresize(Y, [row, col]);
        ro(k) = corr2(MAPFA{1,k},Y);
    end
    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        out=cell2mat(MAPFA(2,pos));    
        final_output=[final_output out];
    end
end

file = fopen('number_Plate.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
winopen('number_Plate.txt')