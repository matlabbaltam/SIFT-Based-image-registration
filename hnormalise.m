function nx = hnormalise(x)
    
    [rows,npts] = size(x);
    nx = x;

    % Find the indices of the points that are not at infinity
    finiteind = find(abs(x(rows,:)) > eps);

%    if length(finiteind) ~= npts
%        warning('Some points are at infinity');
%    end

    % Normalise points not at infinity
    for r = 1:rows-1
        nx(r,finiteind) = x(r,finiteind)./x(rows,finiteind);
    end
    nx(rows,finiteind) = 1;