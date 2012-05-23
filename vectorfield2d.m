function h = vectorfield2d( odesys, xcoords, ycoords, t, varargin )
% VECTORFIELD2D Plot the directional field of a 2-dimensional ODE system in the phase plane.
%   Input:
%       odesys - an ode function handle, of the type used for ode solvers:
%                dydt = f(t, y, ...)
%       xcoords, ycoords - vectors of x- and y-coordinates defining a grid 
%                of points at which to draw arrows
%       t - a fixed time value to use if the system is non-autonomous
%       varargin - extra parameters of the ode function if any
%   Output:
%       h - quiverplot handle
%
%   Author: Nezar Abdennur <nabdennur@gmail.com>
%   Copyright: (C) Nezar Abdennur 2012
%   Datestamp: 2012-05-17

% NOTE: look at stream plots...

if ~exist('t','var') || isempty(t)
    t = 0;
end
m  = length(xcoords);
n  = length(ycoords);
xdot = zeros(n,m);
ydot = zeros(n,m);

for i = 1:m
    for j = 1:n
        grad = odesys(t, [xcoords(i); ycoords(j)], varargin{:});
        xdot(j,i) = grad(1);
        ydot(j,i) = grad(2);
    end
end

arrows = sqrt(xdot.^2+ydot.^2);
h = quiver(xcoords,ycoords, xdot./arrows,ydot./arrows, 0.5, 'r');
%axis tight;