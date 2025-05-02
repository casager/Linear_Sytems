% Find the poles of the system (the eigenvalues of A)
[M, EVal] = eig(A);

% Display the eigenvalues and eigenvectors
disp('The J matrix (M^(-1)AM) of normal form is:');
disp((EVal));
disp('The system eigenvalues are:');
EvalVec=diag(EVal);
disp(EvalVec)
disp('The system eigenvectors are (M matrix):');
disp((M));

% calculate and display modes 
for i=1:size(A,1)
   fprintf('Mode%d: e^(%.4f + %.4fi)*[%.4f+%.4fi, %.4f + %.4fi, %.4f + %.4fi]^T\n', ...
       i, real(EvalVec(i)), imag(EvalVec(i)), ...
       real(M(1,i)), imag(M(1,i)), ...
       real(M(2,i)), imag(M(2,i)), ...
       real(M(3,i)), imag(M(3,i)) ...
       )
end
