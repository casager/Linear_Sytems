clc; clear; close all;

% Define the system matrices A and B
A = [-10 0 -10 0;
    0 -0.7 9 0;
    0 -1 -0.7 0;
    1 0 0 0];  % Example matrix A (system dynamics)

% disp(A);

B = [20 2.8;
    0 -3.13;
    0 0;
    0 0];        % Example matrix B (input matrix)

C = [0 0 1 0; %checking function
    0 0 0 1];

% Find the poles of the system (the eigenvalues of A)
[M, EVal] = eig(A);

% Display the poles
disp('The system eigenvalues are:');
% disp((EVal));
disp(diag(EVal))
disp('The system eigenvectors are (M matrix):');
disp((M));

% 
% diag = [0 0 0 0;
%     0 -10 0 0;
%     0 0 -0.7+3i 0;
%     0 0 0 -0.7-3i];

% disp(diag)
% M2 = [-10 -.7-3i -.7+3i 0;
%     0 -7.74+4.653i -7.74-4.563i 0;
%     0 1.551+2.58i 1.551-2.58i 0;
%     1 1 1 1];

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

% A2 = [0 2; %example 13.3 from book - used for testing
%     0 3];
% 
% B2 = [0;A
%     1];
% eigVals = [-3 -4];

EigenList = transpose(diag(EVal)); 
NewPoleList = [-1 -11 -8+3i -8-3i]; %these are the poles that I moved 
% disp(EigenList)
% [-1 -11 -8+3i -8-3i]; good for phi, p, and almost r when IC = pi/4
% [-0.5 -17 -8+3i -5-3i] good for beta state
% HWEigenList = [-3 -4 -4 -5 -5]; %FIXME


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

Poles_Ob = [-12 -13 -14 -15];

[K0_T] = solveKMatrix(transpose(A), transpose(C), Poles_Ob); %result is the transpose K0

K0 = K0_T';

%Checking to see if K calculation was correct
Ao = transpose(A) - transpose(C)*(K0_T);
[Mo, EValo] = eig(Ao);
check_eig_ob = transpose(diag(EValo));
fprintf("Checking to ensure that observer pole calculations are correct:\n")
for i=1:length(check_eig_ob)
    fprintf('lambda(%d) = %.2f + %.2fi\n', i, real(check_eig_ob(i)), imag(check_eig_ob(i)))
end


    
