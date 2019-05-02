
width = 100000; % um
height = 100000; % um

I=imread('lake.jpg'); % Change input filename here

factor = 0.1; % Change this number to increase/decrease resolution

I = rgb2gray(imresize(I, factor));

imshow(I);

pixelXScale = width / size(I,2);
pixelYScale = pixelXScale;

figure(1);
clf;
hold on;

fp = dxf_open('output.dxf');

for i=1:size(I,1)
    cy = -i*pixelYScale;
    for j=1:size(I,2)
        cx = j*pixelXScale;
        f = sqrt(1-double(I(i,j))/255);
        sx = pixelXScale * f;
        sy = pixelYScale * f;
        
        X = [cx-0.5*sx, cx-0.5*sx, cx+0.5*sx, cx+0.5*sx];
        Y = [cy-0.5*sy, cy+0.5*sy, cy+0.5*sy, cy-0.5*sy];
        X(5) = X(1);
        Y(5) = Y(1);
        
        fill(X,Y, 'b', 'EdgeColor', 'none');
        dxf_polyline(fp,X(:),Y(:),[]);
    end
    i
end

dxf_close(fp);