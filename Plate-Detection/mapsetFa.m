di=dir('Map Set FA/');
st={di.name};
nam=st(3:end);
len=length(nam);


MAPFA=cell(2,len);
for i=1:len
   MAPFA(1,i)={imread(['Map Set FA','/',cell2mat(nam(i))])};
   temp=cell2mat(nam(i));
   MAPFA(2,i)={temp(1)};
end

save('mapsetfa.mat','MAPFA');