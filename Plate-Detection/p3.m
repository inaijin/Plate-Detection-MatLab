[file, path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'}, 'Choose Your Plate !');
plate =[path,file];
picture = imread(plate);
picture=imresize(picture,[600 800]);
picture = rgb2gray(picture);
threshold = graythresh(picture);
picture = ~imbinarize(picture, threshold-0.017);
width = 600;
length = 800;

picture = bwareaopen(picture, 150);
background = bwareaopen(picture, 1700);

picture = picture - background;

maxRowChanges = 0;
maxColsChange = 0;
yMaxChange = 1;
xMaxChange= 1;
rowsChangesCount = zeros(1, width);
colsChangeCount = zeros(1, length);

for i=1: width
    changesCount = 0;
    for j=1: length - 1
        if picture(i, j + 1) ~= picture(i, j)
            changesCount = changesCount + 1;
        end
    end
    rowsChangesCount(i) = changesCount;
    if changesCount > maxRowChanges && i > 340 && i < 500
        maxRowChanges = changesCount;
        yMaxChange = i;
    end
end

yDown = width - 100;
yTop = 100;

xRight = length - 100;
xLeft = 100;

for i=100: yMaxChange
    if abs(maxRowChanges - rowsChangesCount(i)) < 20 && yMaxChange - i < 50
        yTop = i;
        break;
    end
end    

for i=width - 100:-1: yMaxChange
    if abs(maxRowChanges - rowsChangesCount(i)) < 20 && i - yMaxChange < 50
        yDown = i;
        break;
    end
end

for j=1: length
    changesCount = 0;
    for i=1: width - 1
        if picture(i + 1, j) ~= picture(i, j)
            changesCount = changesCount + 1;
        end
    end
    colsChangeCount(i) = changesCount;
    if changesCount > maxColsChange && j > 300 && j < 400
        maxColsChange = changesCount;
        xMaxChange = j;
    end
end

for j=220: xMaxChange
    if abs(maxColsChange - colsChangeCount(j)) < 30 && xMaxChange - j < 230
        xLeft = j;
        break;
    end
end

for j=length - 200:-1: xMaxChange
    if abs(maxColsChange - colsChangeCount(j)) < 30 && j - xMaxChange < 300
        xRight = j;
        break;
    end
end

deltaY = yDown - yTop;

if deltaY < 60
    yDown = yDown + 80 - deltaY;
end

plate = picture(yTop:yDown,xLeft:xRight);

picture = plate;

imshow(picture);

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