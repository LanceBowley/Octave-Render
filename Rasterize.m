function [image] = Rasterize(mesh, mesh2D, meshBounds, projection2D, ...
objectImage, projectionResolution)

nFaces = size(mesh, 1);

yMax = projectionResolution(1, 1);
xMax = projectionResolution(1, 2);

image = zeros(size(objectImage));

for i = 1:nFaces

  face = mesh2D((3*(i - 1) + 1):3*i, :);
  faceBound = meshBounds((2*(i - 1) + 1):2*i, :);
  
  for j = faceBound(1, 2):faceBound(2, 2)
  
    if j > 0 && j <= yMax  
    
      for k = faceBound(2, 1):faceBound(1, 1)
      
        if k > 0 && k <= xMax
          index = (k - 1)*yMax + j;
          pixelCoordiante = projection2D(index, :);
      
          if Contained(pixelCoordiante, face)

            c1 = objectImage(mesh(i, 1));
            c2 = objectImage(mesh(i, 2));
            c3 = objectImage(mesh(i, 3));
            cAverage = (c1 + c2 + c3)/3;
            image(index) = cAverage;
            
          endif
        endif
      endfor
    endif
  endfor
endfor

image = flipud(image);
image = reshape(image, projectionResolution);

end