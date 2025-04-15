function [K] = solveKMatrix(A, B, eigenvalues)
    % A: 4x4 matrix
    % B: 4x2 matrix
    % eigenvalues: vector of 4 eigenvalues from matrix A
    fprintf('------------------------\n')
    fprintf('SOLVING FOR THE K MATRIX\n')
    row_len = size(A,1);
    
    % disp(row_len)
    I = eye(size(A,1));  % Identity matrix of size 4
    Z = [];      % Initialize the matrix to store the solutions
    
    % Iterate over each eigenvalue and compute Xz = 0
    for i = 1:length(eigenvalues)
        lambda = eigenvalues(i);  % Eigenvalue
        % Form the matrix [lambda*I - A | B]
        matrix = [lambda*I - A, B];
        disp(matrix);

        % Solve Xz = 0 for z, using the left null space (which is equivalent to solving the homogeneous system)
        % Using the pseudoinverse to get the solution to the underdetermined system
        z = null(matrix);
        
        % Concatenate the solution z horizontally (along columns)
        p=1; %variable helps with repeated roots
        for j = 1:i-1
            if eigenvalues(j)==eigenvalues(i)
                p=p+1;
            end
        end
        fprintf('p=%.4f\n', p);
        Z = [Z, z(:,p)];

        
        % Display results
        fprintf('For eigenvalue %.4f + %.4fi, the solution z is:\n', real(lambda), imag(lambda));
        disp(z(:,p));
    end
    disp(Z)
    G = Z(1:row_len, 1:row_len);
    disp('The resulting G matrix is:');
    disp(G)
    % disp(B)
    % disp(size(B,2)) %accessing second dimension (i.e. num of columns)
    F = Z(row_len+1:row_len+size(B,2), 1:row_len); %Z(5:6, 1:4) for 4x4 A matrix
    disp('The resulting F matrix is:');
    disp(F);
    
    % Calculating our K matrix now
    K=[];

    if det(G) ~= 0  % Ensure G is invertible before computing the inverse
        G_inv = inv(G);  % Compute the inverse of G
        disp('The inverse of G is:');
        disp(G_inv);
        
        % Compute K = F * G_inv
        K = F * G_inv;
        K=real(K); % only had real vals anyway, neeeded to make real for simulink
        disp('The resulting K matrix is:');
        disp(K);
    else
        disp('G is not invertible, cannot compute K.');
    end

end
