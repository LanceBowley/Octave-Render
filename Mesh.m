function [objectMesh] = Mesh(coordinates, resolution, image)

vP = resolution(1);
hP = resolution(2);
nPixels = vP*hP;
nFaces = 2*(hP - 1)*(vP - 1);

X = reshape(coordinates(:, 1), vP, hP);
Y = reshape(coordinates(:, 2), vP, hP);
Z = reshape(coordinates(:, 3), vP, hP);

image = reshape(image, vP, hP);

objectMesh = zeros(nFaces, 3);

# Add the vertical vertices to the mesh faces ----------------------------------

for i = 1:vP

  index = (i - 1)*hP + 1;
  f1 = 1 + 2*(hP - 1)*(i - 1);
  f2 = f1 - 2*(hP - 1) + 1;
  f3 = f1 - 2*(hP - 1);

  if i == 1
    objectMesh(f1, :) = Append(objectMesh(f1, :), index);
  elseif i == vP
    objectMesh(f2, :) = Append(objectMesh(f2, :), index);
    objectMesh(f3, :) = Append(objectMesh(f3, :), index);
  else
    objectMesh(f1, :) = Append(objectMesh(f1, :), index);
    objectMesh(f2, :) = Append(objectMesh(f2, :), index);
    objectMesh(f3, :) = Append(objectMesh(f3, :), index);
  endif

  index = i*hP;
  f1 = 2*i*(hP - 1);
  f2 = f1 - 1;
  f3 = f1 - 2*(hP - 1);

  if i == 1
    objectMesh(f1, :) = Append(objectMesh(f1, :), index);
    objectMesh(f2, :) = Append(objectMesh(f2, :), index);
  elseif i == vP
    objectMesh(f3, :) = Append(objectMesh(f3, :), index);
  else
    objectMesh(f1, :) = Append(objectMesh(f1, :), index);
    objectMesh(f2, :) = Append(objectMesh(f2, :), index);
    objectMesh(f3, :) = Append(objectMesh(f3, :), index);
  endif
  
endfor

# Add the horizontal vertices to the mesh faces --------------------------------

for i = 1:(hP - 2)

  index = i + 1;
  f1 = 2*(i - 1) + 1;
  f2 = f1 + 1;
  f3 = f1 + 2;
  objectMesh(f1, :) = Append(objectMesh(f1, :), index);
  objectMesh(f2, :) = Append(objectMesh(f2, :), index);
  objectMesh(f3, :) = Append(objectMesh(f3, :), index);
  
  index = (vP - 1)*hP + i + 1;
  f1 = 2*(hP - 1)*(vP - 2) + 2*(i - 1) + 2;
  f2 = f1 + 1;
  f3 = f1 + 2;
  objectMesh(f1, :) = Append(objectMesh(f1, :), index);
  objectMesh(f2, :) = Append(objectMesh(f2, :), index);
  objectMesh(f3, :) = Append(objectMesh(f3, :), index);
  
endfor

# Add center vertices to the mesh faces ----------------------------------------

for i = 2:(vP - 1)
  for j = 2:(hP - 1)
    
    index = (i - 1)*hP + j;
    f1 = 2*(i - 2)*(hP - 1) + 2*(j - 1);
    f2 = f1 + 1;
    f3 = f1 + 2;
    f4 = f1 + 2*(hP - 1) - 1;
    f5 = f4 + 1;
    f6 = f4 + 2;
    objectMesh(f1, :) = Append(objectMesh(f1, :), index);
    objectMesh(f2, :) = Append(objectMesh(f2, :), index);
    objectMesh(f3, :) = Append(objectMesh(f3, :), index);
    objectMesh(f4, :) = Append(objectMesh(f4, :), index);
    objectMesh(f5, :) = Append(objectMesh(f5, :), index);
    objectMesh(f6, :) = Append(objectMesh(f6, :), index);
    
  endfor
endfor

function [indexArray2] = Append(indexArray1, index)

  indexArray2 = indexArray1;

  if indexArray1(1, 1) == 0
  
    indexArray2(1, 1) = index;
    
  elseif indexArray1(1, 2) == 0
  
    indexArray2(1, 2) = index;
    
  else 
  
    indexArray2(1, 3) = index;
  
  endif

end
end


































