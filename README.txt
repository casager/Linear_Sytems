Define your matrices A and B in the main script "start.m"

Run "start.m" either from command window or the gui run button

Explanation:

The main_script.m file defines the system matrices A and B and then uses the eig() function to calculate the poles (eigenvalues) of the system.

It also computes the controllability matrix and checks the system's controllability.

It then calls the solveKMatrix.m file to compute the state feedback gain matrix K based on the desired eigenvalues (closed-loop poles) provided in the script.


What to Expect:

When you run the script, MATLAB will:

Display the system eigenvalues and eigenvectors of matrix A.

Display the controllability matrix and check the system's controllability.

Call the solveKMatrix.m function to compute the state feedback gain matrix K based on the desired closed-loop poles (NewPoleList).

The function will display intermediate steps, such as the computed matrices G and F, as well as the final K matrix.

The eigenvalues of the closed-loop system will also be displayed to ensure the desired poles have been correctly placed and the K calculation is correct.


Running Simulink:

Simply type "simulink" into the command window to start the program.

In simulink, open the model "model.slx" and observe or alter the model that has been created.

You can also alter just the initial approximation values of the states in order to view all of the report graphs (double click on scopes).


Verify the Output (Summary):

The output will include the eigenvalues of the open-loop system, the controllability check, and the state feedback matrix K.

You'll also see a check of the calculated poles to ensure they match the desired ones.


Errors in Calculation: If there are any issues with matrix sizes or calculations, double-check that the matrices A and B are defined correctly, 

and ensure that NewPoleList has the right number of poles

Additionally, if the Z matrix in solveKMatrix.m is not independent, then G is not invertible and K cannot be calculated.

Therefore, be sure to choose independent columns at that point.