function H = Homo_prime(W)
    X = W(1:3,:);
    Y = W(4:6,:);
    Xh = X';
    Yh = Y';
    A = zeros(2*size(X,2),9);
    for i = 0:size(Xh,1)-1,
        A(2*i+1,1:3) = Xh(i+1,:);
        A(2*i+1,7:9) = -Yh(i+1,1)*Xh(i+1,:);
        A(2*(i+1),4:6) = Xh(i+1,:);
        A(2*(i+1),7:9) = -Yh(i+1,2)*Xh(i+1,:);
    end
    [U,S,V] = svd(A);
    H = (reshape(V(:,9),3,3))';
    H = H/H(3,3);
