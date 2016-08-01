function [coordinates, orientation, bounds] = Plane(location, ...
aspectRatio, angle, resolution)

# Establish dimensions ---------------------------------------------------------

point1 = location(1, :);
point2 = location(2, :);
horizontalLength = norm(point2 - point1);
verticalLength = horizontalLength*aspectRatio;

# Create unit vectors ----------------------------------------------------------

horizontalUnit = (point2 - point1)./horizontalLength;
normalVector0 = cross(horizontalUnit, [0, 1, 0]);
normalUnit0 = normalVector0./(norm(normalVector0));
verticalUnit0 = cross(horizontalUnit, normalUnit0);
verticalUnit = RodriguesRotation(horizontalUnit, -verticalUnit0, angle);
normalUnit = cross(verticalUnit, -horizontalUnit);
orientation = [horizontalUnit; verticalUnit; normalUnit];

# Find pixel dimensions --------------------------------------------------------

horizontalPixels = resolution(2);
verticalPixels = resolution(1);
nPixels = horizontalPixels*verticalPixels;
horizontalPixelLength = horizontalLength/horizontalPixels;
verticalPixelLength = verticalLength/verticalPixels;

# Get pixel displacement vectors -----------------------------------------------

horizontalDelta = horizontalPixelLength.*horizontalUnit;
verticalDelta = verticalPixelLength.*verticalUnit;

# Define the 3D corner boundaries of the plane ---------------------------------

p1 = point1 + 0.5*verticalLength.*verticalUnit;
p2 = p1 + horizontalLength.*horizontalUnit;
p3 = p1 - verticalLength.*verticalUnit;
p4 = p3 + horizontalLength.*horizontalUnit;
bounds = [p1; p2; p3; p4];

# Initialize the first pixel 3D coordinate -------------------------------------
 
position = p1 + 0.5.*horizontalDelta - 0.5.*verticalDelta;

# Create an empty set of coordinates and fill them up --------------------------

emptySet = zeros(verticalPixels, horizontalPixels);
X = emptySet;
Y = emptySet;
Z = emptySet;

for i = 1:verticalPixels
  for j = 1:horizontalPixels

    coordinate = position + (j - 1)*horizontalDelta - (i - 1)*verticalDelta;
    X(i, j) = coordinate(1, 1);
    Y(i, j) = coordinate(1, 2);
    Z(i, j) = coordinate(1, 3);

  endfor
endfor

# Pass the coordinate grids to an array-----------------------------------------

X = reshape(X, nPixels, 1);
Y = reshape(Y, nPixels, 1);
Z = reshape(Z, nPixels, 1);
coordinates = [X, Y, Z];

end