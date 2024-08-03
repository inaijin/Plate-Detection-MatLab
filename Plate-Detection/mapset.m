di=dir('Map Set/');
st={di.name};
nam=st(3:end);
len=length(nam);


MAPEN=cell(2,len);
for i=1:len
   MAPEN(1,i)={imread(['Map Set','/',cell2mat(nam(i))])};
   temp=cell2mat(nam(i));
   MAPEN(2,i)={temp(1)};
end

save('mapset.mat','MAPEN');