function [coordinates] = PlaneToSurface(planeCoordinates, ...
orientations, relativeSurface, resolution) 

unitNormal = orientations(3, :);

verticalPixels = resolution(1);
horizontalPixels = resolution(2);
nPixels = verticalPixels*horizontalPixels;

coordinates = zeros(nPixels, 3);
coordinates = planeCoordinates + relativeSurface.*unitNormal;

end