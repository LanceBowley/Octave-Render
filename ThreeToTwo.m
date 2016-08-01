function [coordinates2D] = ThreeToTwo(coordinates, planeOrientation, bounds)

horizontalUnit = planeOrientation(1, :);
verticalUnit = planeOrientation(2, :);

relativeToOrigin = coordinates - bounds(1, :);

xVector = (relativeToOrigin./horizontalUnit);
xVector(~isfinite(xVector)) = 0;

yVector = (relativeToOrigin./verticalUnit);
yVector(~isfinite(yVector)) = 0;

X = sum(xVector, 2);
Y = sum(yVector, 2);

coordinates2D = [X, Y];

end