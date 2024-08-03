[file, path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'}, 'Choose Your Plate !');
plate =[path,file];
picture = imread(plate);
picture=imresize(picture,[300 500]);

picture = mygrayfun(picture);
picture = ~mybinaryfun(picture);
picutre = myremovecom(picture, 300);

background = myremovecom(picture, 2300);

image = picutre - background;

[L,Ne]=mysegmentation(image);
imshow(image);
propied=regionprops(L,'BoundingBox');
hold on
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

load mapset;
totalLetters=size(MAPEN,2);

final_output=[];
t=[];
for n=1:Ne
    [r,c]=find(L==n);
    Y=image(min(r):max(r),min(c):max(c));
    Y=imresize(Y,[42,24]);
    ro=zeros(1,totalLetters);
    for k=1:totalLetters   
        ro(k)=corr2(MAPEN{1,k},Y);
    end

    [MAXRO,pos]=max(ro);
    if MAXRO>.45
        out=cell2mat(MAPEN(2,pos));    
        final_output=[final_output out];
    end
end

file = fopen('number_Plate.txt', 'wt');
fprintf(file,'%s\n',final_output);
fclose(file);
winopen('number_Plate.txt')