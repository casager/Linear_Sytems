% Compute the controllability matrix 
% criterion 1
B_n = EVec\B; %same as inv(EVec) * B
disp('Bn matrix:');
disp(B_n)

% criterion 2
% For a 3x3 system, we need 3 columns: [B, AB, A^2*B]
P_matrix = [B, A*B, A^2*B];  

disp('P_matrix:')
disp(P_matrix)

% Check the rank
rank_P = rank(P_matrix);
disp('Rank of P')
disp(rank_P)

if rank_P == size(A, 1)
    disp('The system is controllable (no 0 rows of Bn and rank(P)=3)');
else
    disp('The system is not controllable');
end

% disp(EVal)

% NewPoleList = [-0.1 -0.2+0.0728i -0.2-0.0728i]; %this made K not too large, but
%the control takes way too long I think...
NewPoleList = [-1 -2+0.0728i -2-0.0728i]; % this actually still makes K large
% NewPoleList = [-1 -2+0.2409i -2-0.2409i];
% NewPoleList = [-4 -5+0.0728i -5-0.0728i]; % a lot of oscillation...
% NewPoleList = [-4 -5 -6];

% reference values for desired gap distance
x_ref=[0.01, 0, 0.002];

% Class method for K matrix
% signals are real anyway but need 0.000i term removed
v = 1;
[K] = real(solveKMatrix_class(A,B,NewPoleList, v));
disp('class method K:');
disp(K)

% "place" method for K matrix - MATCHES CLASS METHOD
[K_place] = place(A,B,NewPoleList);
disp('place method K:');
disp(K_place)

% Checking to see if K calculation was correct
% Change this to K_place and K_LQR to check
Ac = A - B*K;
[M2, EVal2] = eig(Ac);
check_eig = transpose(diag(EVal2));
fprintf("Checking to ensure that pole calculations are correct:\n")
for i=1:length(check_eig)
    fprintf('lambda(%d) = %.4f + %.4fi\n', i, real(check_eig(i)), imag(check_eig(i)))
end
fprintf('\n');

% LQR METHOD
% State weights: penalize gap error (x1), velocity (x2), and current (x3)
Q = diag([100, 10, 1]);   % Heavily penalize position error
% Input weight: penalize large voltage commands
R = 1;   % Tune this to be larger if voltage effort is too aggressive
% Compute LQR gain
[K_LQR, S, poles_LQR] = lqr(A, B, Q, R);

disp('LQR gain K:');
disp(K_LQR);
disp('LQR closed-loop poles:');
disp(poles_LQR);