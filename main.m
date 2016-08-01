pkg load image
warning('off', 'Octave:possible-matlab-short-circuit-operator');

# Define resolution ------------------------------------------------------------

canvasResolution = [175, 175];
nCanvasPixels = canvasResolution(1)*canvasResolution(2);

# Import raw image and change resolution ---------------------------------------

rawImage = 255*CheckerBoard();
#rawImage = imread('TestPictures/city.jpg');
#rawGsImage = rgb2gray(rawImage);
rawGsImage = mat2gray(rawImage, [0 255]);
image = imresize(rawGsImage, canvasResolution);
image = reshape(image, nCanvasPixels, 1);

# Import raw depth map and match canvas resolution -----------------------------

mapLocation = [-1, 0, 0; 1, 0, 0];
mapAspectRatio = 1;
mapAngle = 0;
mapCoordinates = Plane(mapLocation, mapAspectRatio, mapAngle, ...
canvasResolution);
depthMap = GaussianFunction(mapCoordinates(:, 1), mapCoordinates(:, 2), ...
canvasResolution);
depthMap = reshape(depthMap, nCanvasPixels, 1); 
#depthMap = -1*ones(nCanvasPixels, 1);

# Set a coordinate system for new image canvas ---------------------------------

imageLocation = [-1, 0, -3; 1, 0, -3]; # Lateral bisector points
imageAspectRatio = 1; # vertical length compared to the horizontal length
imageAngle = 0; # Angle in degrees where +angle --> +tilt forward
[imageCoordinates, imageOrientation] = Plane(imageLocation, ...
imageAspectRatio, imageAngle, canvasResolution);

# Modify image canvas to match the object surface ------------------------------

objectCoordinates = PlaneToSurface(imageCoordinates, imageOrientation, ...
depthMap, canvasResolution);

# Set up projection planes -----------------------------------------------------

projectionResolution = [175, 175];
projectionAspectRatio = 1;
projectionAngle = 0;
focalDistance = 1.5;

leftProjectionLocation = [0.9, 0, 0.5; -1.1, 0, 0.5];
[leftProjection, leftProjectionOrientation, leftProjectionBounds] ...
= Plane(leftProjectionLocation, projectionAspectRatio, ...
projectionAngle, projectionResolution);

rightProjectionLocation = [1.1, 0, 0.5; -0.9, 0, 0.5];
[rightProjection, rightProjectionOrientation, ...
rightProjectionBounds] = Plane(rightProjectionLocation, ...
projectionAspectRatio, projectionAngle, projectionResolution);

# Convert projection planes to 2D local coordinates ----------------------------

leftProjection2D = ThreeToTwo(leftProjection, leftProjectionOrientation, ...
leftProjectionBounds);
rightProjection2D = ThreeToTwo(rightProjection, rightProjectionOrientation, ...
rightProjectionBounds);

# Set up projection focal points -----------------------------------------------

leftFocalPoint = FocalPoint(leftProjectionOrientation, ...
leftProjectionLocation, focalDistance);

rightFocalPoint = FocalPoint(rightProjectionOrientation, ...
rightProjectionLocation, focalDistance);

# Convert coordinates to a triangular mesh -------------------------------------

objectMesh = Mesh(objectCoordinates, canvasResolution, image);

# Project the object coordinates to the left and right projection planes and ---
# convert to the local planar coordinate system --------------------------------

leftObjectProjection = LinePlaneIntersection(objectCoordinates, ...
leftProjection, leftProjectionOrientation, leftFocalPoint);
leftObjectProjection2D = ThreeToTwo(leftObjectProjection, ...
leftProjectionOrientation, leftProjectionBounds);

rightObjectProjection = LinePlaneIntersection(objectCoordinates, ...
rightProjection, rightProjectionOrientation, rightFocalPoint);
rightObjectProjection2D = ThreeToTwo(rightObjectProjection, ...
rightProjectionOrientation, rightProjectionBounds);

# Arrange 2D projection into columns of [3 x 2] faces --------------------------

leftObjectMesh = ArrangeFaces(leftObjectProjection2D, objectMesh);
rightObjectMesh = ArrangeFaces(rightObjectProjection2D, objectMesh);

# Determine the projection index bounds for each face --------------------------

leftMeshBounds = Bounds(leftObjectMesh, leftProjectionBounds, ...
projectionResolution);
rightMeshBounds = Bounds(rightObjectMesh, rightProjectionBounds, ...
projectionResolution);

# Rastrize each projection plane with projected object meshes ------------------

leftImage = Rasterize(objectMesh, leftObjectMesh, leftMeshBounds, ...
leftProjection2D, image, projectionResolution);

rightImage = Rasterize(objectMesh, rightObjectMesh, rightMeshBounds, ...
rightProjection2D, image, projectionResolution);

# View left and right perspectives ---------------------------------------------

subplot(1, 2, 1);
imshow(rightImage, [0, 1])

subplot(1, 2, 2);
imshow(leftImage, [0, 1])








































































































































