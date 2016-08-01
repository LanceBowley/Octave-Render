# NOTE: This funtion assumes that the object will be projected completely within
# the bounds of the projection canvas ------------------------------------------

function [indexBounds] = Bounds(mesh2D, projectionBounds, projectionResolution)

faces = size(mesh2D, 1)/3;
bounds = zeros(2*faces, 2);

for i = 1:faces

  X = mesh2D(((3*(i - 1) + 1):3*i), 1);
  Y = mesh2D(((3*(i - 1) + 1):3*i), 2);

  maxX = max(X);
  minX = min(X);
  maxY = max(Y);
  minY = min(Y);

  bounds((2*(i - 1) + 1):2*i, :) = [maxX, maxY; minX, minY];

endfor

projectionWidth = norm(projectionBounds(2, :) - projectionBounds(1, :));
projectionHeight = norm(projectionBounds(3, :) - projectionBounds(1, :));

horizontalPixels = projectionResolution(1, 1);
verticalPixels = projectionResolution(1, 2);

pixelHeight = projectionHeight/verticalPixels;
pixelWidth = projectionWidth/horizontalPixels;

deltas = [pixelWidth, pixelHeight];
offset = [0.5*pixelWidth, -0.5*pixelHeight];

indexBounds = ((bounds - offset)./deltas);

for i = 1:(2*faces)

  if mod(i, 2) == 0
  
    indexBounds(i, :) = int16(floor(indexBounds(i, :))) - 1;
    
  else 
  
    indexBounds(i, :) = int16(ceil(indexBounds(i, :))) + 1;
  
  endif
endfor

indexBounds = abs(indexBounds);

end