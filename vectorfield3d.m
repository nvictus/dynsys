function h = vectorfield3d( odesys, xcoords, ycoords, zcoords, t, varargin )
% VECTORFIELD3D Plot the directional field of a 3-dimensional ODE system in phase space.
%   Input:
%       odesys - an ode function handle, of the type used for ode solvers:
%                dydt = f(t, y, ...)
%       xcoords, ycoords, zcoords - vectors of coordinates defining a 3D 
%                grid of points at which to draw arrows
%       t - a fixed time value to use if the system is non-autonomous
%       varargin - extra parameters of the ode function if any
%   Output:
%       h - quiverplot handle
%
%   Author: Nezar Abdennur <nabdennur@gmail.com>
%   Copyright: (C) Nezar Abdennur 2012
%   Datestamp: 2012-05-17

% NOTE: look at stream slices...

if ~exist('t','var') || isempty(t)
    t = 0;
end
m = length(xcoords);
n = length(ycoords);
p = length(zcoords);
xdot = zeros(n,m,p);
ydot = zeros(n,m,p);
zdot = zeros(n,m,p);
[x,y,z] = meshgrid(xcoords,ycoords,zcoords);

for i = 1:m
    for j = 1:n
        for k = 1:p
            grad = odesys(t, [xcoords(i); ycoords(j); zcoords(k)], varargin{:});
            xdot(j,i,k) = grad(1);
            ydot(j,i,k) = grad(2);
            zdot(j,i,k) = grad(3);
        end
    end
end

arrows = sqrt(xdot.^2+ydot.^2+zdot.^2);
h = quiver3(x,y,z, xdot./arrows,ydot./arrows,zdot./arrows, 0.5);

end