% Compute the controllability matrix 
% criterion 1
C_n = C*EVec; %same as inv(EVec) * B
disp('Cn matrix:');
disp(C_n)

% criterion 2
% For a 3x3 system, we need 3 columns: [B, AB, A^2*B]
Q_matrix = [C', A'*C', (A^2)'*C'];  

disp('Q_matrix:')
disp(Q_matrix)

% Check the rank
rank_Q = rank(Q_matrix);
disp('Rank of Q')
disp(rank_Q)

if rank_P == size(A, 1)
    disp('The system is controllable (no 0 rows of Cn and rank(Q)=3)');
else
    disp('The system is not controllable');
end

Poles_Ob = [-3 -4+0.0728i -4+-0.0728i]; %way too much for the class place
% - the graph starts to explode
% Poles_Ob = [-0.2 -0.3+0.0728i -0.3+-0.0728i];
% Poles_Ob = [-5 -6 -7]; %if we do not have any freq compoent, get high
% oscillation

% Class method for K matrix
% signals are real anyway but need 0.000i term removed
v = [10 0.25]'; %adjust this until reasonable control values. 
% when this is [1 1] with very high gain, we go out of control
[K0_T] = real(solveKMatrix_class(A', C', Poles_Ob, v)); %result is the transpose K0
K0 = K0_T';
disp('class method K0:');
disp(K0)

% "place" method for K matrix - MATCHES CLASS METHOD
[K0_T_place] = place(A',C',Poles_Ob);
K0_place = K0_T_place';
disp('place method K0:');
disp(K0_place)

% Checking to see if K0 calculation was correct
% Change this to K0_T_place and K0_T_LQR to check
Ao = transpose(A) - transpose(C)*(K0_T);
[EVec_o, EVal_o] = eig(Ao);
check_eig_ob = transpose(diag(EVal_o));
fprintf("Checking to ensure that observer pole calculations are correct:\n")
for i=1:length(check_eig_ob)
    fprintf('lambda(%d) = %.4f + %.4fi\n', i, real(check_eig_ob(i)), imag(check_eig_ob(i)))
end
fprintf('\n');

% Compute LQR gain
[K0_T_LQR, S_ob, poles_LQR_ob] = lqr(A', C', Q, R);
K0_LQR = K0_T_LQR';
% disp('LQR gain K:');
% disp(K0_LQR);
% disp('Closed-loop poles:');
% disp(poles_LQR_ob);
