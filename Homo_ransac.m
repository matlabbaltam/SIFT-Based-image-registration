function H = Homo_ransac(W);
    x1 = W(1:3,:);
    x2 = W(4:6,:);
    s = 4;
    t = 0.0015;
    fittingfn = @Homo_norm;
    distfn = @homogdist2d;
    degenfn = @isdegenerate;
    [H, inliers] = ransac([x1; x2], fittingfn, distfn, degenfn, s, t);
    % Now do a final least squares fit on the data points considered to
    % be inliers.
    H = Homo_norm([x1(:,inliers); x2(:,inliers)]);