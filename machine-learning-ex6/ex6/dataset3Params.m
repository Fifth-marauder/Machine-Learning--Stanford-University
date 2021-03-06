function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
%C = 1;
%sigma = 0.3;
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

c_list=[0.01 0.03 0.1 0.3 1 3 10 30];
s_list=[0.01 0.03 0.1 0.3 1 3 10 30];

results = zeros(length(c_list) * length(s_list), 3);

row=1;
for i = 1:length(c_list)
  for j = 1: length(s_list)
    cVal=c_list(i);
    sVal=s_list(j);
    model= svmTrain(X, y, cVal, @(x1, x2) gaussianKernel(x1, x2, sVal));
    
    predictions = svmPredict(model, Xval);
    prediction_error = mean(double(predictions ~= yval));
    results(row,:) = [prediction_error, cVal, sVal ]
    row = row + 1;
  endfor
endfor

[val ind]=min(results(:,1));
C=results(ind,2);
sigma=results(ind,3);
%sorted_result=sortrows(results,1);
%C=sorted_result(1,2);
%sigma=sorted_result(1,3);




% =========================================================================

end
