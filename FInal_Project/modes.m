% Find the poles of the system (the eigenvalues of A)
[EVec, EVal] = eig(A);

% Display the eigenvalues and eigenvectors
disp('The J matrix (M^(-1)AM) of normal form is:');
disp((EVal));
disp('The system eigenvalues are:');
EValList=diag(EVal);
disp(EValList)
disp('The system eigenvectors are (M matrix):');
disp((EVec));

% calculate and display modes 
for i=1:size(A,1)
   fprintf('Mode%d: e^(%.4f + %.4fi)*[%.4f+%.4fi, %.4f + %.4fi, %.4f + %.4fi]^T\n', ...
       i, real(EValList(i)), imag(EValList(i)), ...
       real(EVec(1,i)), imag(EVec(1,i)), ...
       real(EVec(2,i)), imag(EVec(2,i)), ...
       real(EVec(3,i)), imag(EVec(3,i)) ...
       )
end
