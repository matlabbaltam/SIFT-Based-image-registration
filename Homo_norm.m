function H = Homo_norm(W)
    X = W(1:3,:);
    Y = W(4:6,:);
    %% Calculate T and T'
    Xh = X';
    ave = mean(Xh(:,1:2),1);
    tx = ave(1);
    ty = ave(2);
    s = sqrt(2)/(mean(sqrt((Xh(:,1)-mean(Xh(:,1))).^2+(Xh(:,2)-mean(Xh(:,2))).^2)));
    T = [s 0 -s*tx;0 s -s*ty;0 0 1];
    Xh_norm = (T*Xh')';
    Yh = Y';
    ave = mean(Yh(:,1:2),1);
    tx = ave(1);
    ty = ave(2);
    s = sqrt(2)/(mean(sqrt((Yh(:,1)-mean(Yh(:,1))).^2+(Yh(:,2)-mean(Yh(:,2))).^2)));
    TY = [s 0 -s*tx;0 s -s*ty;0 0 1];
    Yh_norm = (TY*Yh')';


    A = zeros(2*size(X,2),9);
    for i = 0:size(Xh_norm,1)-1,
        A(2*i+1,1:3) = Xh_norm(i+1,:);
        A(2*i+1,7:9) = -Yh_norm(i+1,1)*Xh_norm(i+1,:);
        A(2*(i+1),4:6) = Xh_norm(i+1,:);
        A(2*(i+1),7:9) = -Yh_norm(i+1,2)*Xh_norm(i+1,:);
    end
    [U,S,V] = svd(A);
    H = (reshape(V(:,9),3,3))';
    H = inv(TY)*H*T;
    H = H/H(3,3);

