function [focalPoint] = FocalPoint(projectionOrientation, ...
projectionLocation, focalDistance)

unitNormal = projectionOrientation(3, :);
projectionCenter = (projectionLocation(1, :) + projectionLocation(2, :))/2;
focalPoint = projectionCenter - focalDistance.*unitNormal;

end