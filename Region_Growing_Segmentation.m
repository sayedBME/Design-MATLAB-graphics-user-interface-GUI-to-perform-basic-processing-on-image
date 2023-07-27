clc
clear all
close all
[file,path]=uigetfile({'*.*'});
img_loc=fullfile(path,file);
Im=im2double(imread(img_loc));
Gray=rgb2gray(Im);
figure
imshow(Gray,[])
[x,y]=ginput(1);
x = round(x); y = round(y);
g=Im(x,y);
% Seed Point (x,y)
hold on; plot(x,y,'xg'); hold off;
b=[];
[p q]=size(Gray);
for i=1:p
    for j=1:q
        if abs(Gray(i,j)-g)< 0.15
            b(i,j)=0;
        else
            b(i,j)=1;
        end
    end
end
B=imoverlay(Im,b,'yellow');
figure
imshow(B)