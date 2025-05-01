function [K] = solveKMatrix_class(A, B, eigenvalues, v)
    % A: 4x4 matrix
    % B: 4x2 matrix
    % eigenvalues: vector of 4 eigenvalues from matrix A
    fprintf('------------------------\n')
    fprintf('SOLVING FOR THE K MATRIX\n')
    numRowsA = size(A,1);
    
    % disp(row_len)
    I = eye(size(A,1));  % Identity matrix of size A
    Z = [];      % Initialize the matrix to store the solutions
    V= [];
    % v = ones(size(B, 2), 1);
    % v = (1:size(B, 2))'; % v column vector
    
    % Iterate over each eigenvalue and compute Xz = 0
    for i = 1:length(eigenvalues)
        lambda = eigenvalues(i);  % Eigenvalue
        % Form the matrix [lambda*I - A | B]
        mat = [lambda*I - A];
        % disp(mat);

        % v = (1:size(B, 2))';
        % v = [v(1)+1 v(2)+1]'; % choose this if not invertible

        % phi=inv(mat);
        % phiBv = phi*B*v;
        
        phiBv = (mat\B)*v; %equivalent of previous 2 lines
        
        % fprintf('phi[%d]*B*v=%.4f\n', i, phiBv);
        % disp(phiBv)
        V = [V, v];
        Z = [Z, phiBv];

    end
    disp(Z);
    % disp(V);
    % K=-V*inv(Z);
    K=-V/Z; %equivalent of previous line


end
