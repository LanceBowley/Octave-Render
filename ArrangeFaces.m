function [projectedMesh] = ArrangeFaces(objectProjection2D, mesh)

projectedMesh = [];
faces = size(mesh, 1);

  for i = 1:faces 
  
    p1 = mesh(i, 1);
    p2 = mesh(i, 2);
    p3 = mesh(i, 3);
    c1 = objectProjection2D(p1, :);
    c2 = objectProjection2D(p2, :);
    c3 = objectProjection2D(p3, :);
    newFace = [c1; c2; c3];
    projectedMesh = [projectedMesh; newFace];
    
  endfor

end