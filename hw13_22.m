clc; clear; close all;

% Define the system matrices A and B
A = [-2 -2 0;
      0 0 1;
     0 -3 -4];  % Example matrix A (system dynamics)
disp(A)

B = [1 0;
    0 0;
    0 1];        % Example matrix B (input matrix)

C = [1 0 1;
    0 1 0];

% Find the poles of the system (the eigenvalues of A)
[M, EVal] = eig(A);

% Display the poles
disp('The system eigenvalues are:');
% disp((EVal));
disp(diag(EVal))
disp('The system eigenvectors are (M matrix):');
disp((M));

disp('Bn matrix:');
B_n = M\B; %same as inv(M) * B
disp(B_n)

% Compute the controllability matrix
P_matrix = [B, A*B, A^2*B, A^3*B];  % For a 2x2 system, we need two columns: [B, AB]

disp('P_matrix:')
disp(P_matrix)

% Check the rank
rank_P = rank(P_matrix);

disp('Rank of P')
disp(rank_P)

% Compare with the number of states
if rank_P == size(A, 1)
    disp('The system is controllable (no 0 rows of Bn and rank(P)=4)');
else
    disp('The system is not controllable');
end

EigenList = transpose(diag(EVal)); 
NewPoleList = [-3 -3 -4]; %these are the poles that I moved 


% It is good that we separated the matrix A from desired eigenvalues
% (closed-loop poles)
[K] = solveKMatrix(A,B,NewPoleList); 

%Checking to see if K calculation was correct
Ac = A - B*K;
[M2, EVal2] = eig(Ac);
check_eig = transpose(diag(EVal2));
fprintf("Checking to ensure that pole calculations are correct:\n")
for i=1:length(check_eig)
    fprintf('lambda(%d) = %.2f + %.2fi\n', i, real(check_eig(i)), imag(check_eig(i)))
end

Poles_Ob = [-5 -6 -7];

[K0_T] = solveKMatrix(transpose(A), transpose(C), Poles_Ob); %result is the transpose K0

%Checking to see if K calculation was correct
Ao = transpose(A) - transpose(C)*(K0_T);
[Mo, EValo] = eig(Ao);
check_eig_ob = transpose(diag(EValo));
fprintf("Checking to ensure that observer pole calculations are correct:\n")
for i=1:length(check_eig_ob)
    fprintf('lambda(%d) = %.2f + %.2fi\n', i, real(check_eig_ob(i)), imag(check_eig_ob(i)))
end






