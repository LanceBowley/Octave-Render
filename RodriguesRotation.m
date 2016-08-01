# Takes a vector and rotates it about an axis vector

function [vector] = RodriguesRotation(axisVector, rotatingVector, angle)

aV = axisVector;
rV = rotatingVector;
ang = angle;
vector = rV.*cosd(ang) + cross(aV, rV).*sind(ang) + ...
aV.*(dot(aV, rV))*(1-(cosd(ang)));

end