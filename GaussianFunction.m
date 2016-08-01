function [Z] = GaussianFunction(X, Y, resolution)

X = reshape(X, resolution(1), resolution(2));
Y = reshape(Y, resolution(1), resolution(2)); 

A = 4;
x0 = 0;
y0 = 0;
sigx = 1;
sigy = 1;
B = 0;

Z = A*exp(-((((X-x0).^2)/(2*(sigx^2))) + (((Y-y0).^2)/(2*(sigy^2))))) + B;

end