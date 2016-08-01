function [objectProjectionCoordinates] = LinePlaneIntersection(...
objectCoordinates, projectionCoordinates, projectionOrientation, focalPoint) 

objectLineDisplacement = focalPoint - objectCoordinates;
norm = sqrt(sum((objectLineDisplacement.^2), 2));
norm = [norm, norm, norm];
objectLineUnit = objectLineDisplacement./norm;

planeCorner = projectionCoordinates(1, :);
planeNormal = projectionOrientation(3, :);

objectRelativeToCorner = planeCorner - objectCoordinates;

distanceToPlane = (sum((planeNormal.*objectRelativeToCorner), 2))./...
(sum((planeNormal.*objectLineUnit), 2));

objectProjectionCoordinates = objectCoordinates + ...
distanceToPlane.*objectLineUnit;

end