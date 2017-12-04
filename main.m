function main(file1,file2,method)
    image_1 = imread(file1);
    image_2 = imread(file2);
    I1 = single(rgb2gray(image_1));
    I2 = single(rgb2gray(image_2));
    [f1,d1] = vl_sift(I1);
    [f2,d2] = vl_sift(I2);
    [matches, scores] = vl_ubcmatch(d1, d2,1.5);
    Xp = f1(1:2,matches(1,:));
    X = [Xp;ones(1,size(Xp,2))];
    Yp = f2(1:2,matches(2,:));
    Y = [Yp;ones(1,size(Yp,2))];
    W = [X;Y];
    if method ==1
        H = Homo_prime(W);
    elseif method ==2
        H = Homo_norm(W);
    elseif method ==3
        H = Homo_ransac(W);
    end
%     for x1 = 1:size(I1,2)
%         for y1 = 1:size(I1,1)
%             p1 = [x1;y1;1];
%             p2 = H*p1;
%             p2 = p2/p2(3);
%             x2 = round(p2(1));
%             y2 = round(p2(2));
%             if x2>0 && x2<=size(I1,2) && y2>0 && y2<=size(I1,1)
%                 I1new(y2,x2) = I1(y1,x1);
%             end
%         end
%     end
    TT = maketform('projective',H');
    [I1neww,xdata,ydata] = imtransform(I1,TT);
    xdataout=[min(1,xdata(1)) max(size(I2,2),xdata(2))];
    ydataout=[min(1,ydata(1)) max(size(I2,1),ydata(2))];
    I1new = imtransform(I1,TT,'Xdata',xdata,'Ydata',ydata);
    I2new = imtransform(I2,maketform('affine',eye(3)),'XData',xdata,'YData',ydata);
    mosaic = round(I1new/2+I2new/2);
    
%     xdata
%     ydata
%     TT
%     I2 = imresize(I2,size(I
%     Inew = round((I1new+I2)/2);
    imshow(uint8(mosaic),'Xdata',xdata,'Ydata',ydata)
end