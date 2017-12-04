function tf = iscolinear(p1,p2,p3),
    slope = (p2(2)-p1(2))/(p2(1)-p1(1));
    intercept = -p1(2)+slope*p1(1);
    tf = (slope*p3(1)+intercept) == p3(2);
end