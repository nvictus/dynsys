function h = nullclines2d( odesys, xcoords, ycoords, t, varargin )
% NULLCLINES2D Plot the nullclines of a 2-dimensional ODE system in the phase plane.
%   Calculates a grid of values for each of dx/dt and dy/dt and uses
%   contour to plot the level curves where dx/dt=0 and dy/dt=0.
%
%   Input:
%       odesys - an ode function handle, of the type used for ode solvers:
%                dydt = f(t, y, ...)
%       xcoords, ycoords - vectors of x- and y-coordinates defining a grid 
%                of points to evaluate the derivatives
%       t - a fixed time value to use if the system is non-autonomous
%       varargin - extra parameters of the ode function if any
%   Output:
%       h - pair of contourplot handles
%
%   Author: Nezar Abdennur <nabdennur@gmail.com>
%   Copyright: (C) Nezar Abdennur 2012
%   Datestamp: 2012-05-17

if nargin < 4
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

hold_on = ishold(gca);
% x-nullcline
[~, h(1)] = contour(xcoords,ycoords,xdot, [0,0], 'Color', [0 0 0.6], 'Linewidth', 1.5);
hold on;
% y-nullcline
[~, h(2)] = contour(xcoords,ycoords,ydot, [0,0], 'Color', [0 0.6 0], 'Linewidth', 1.5);
if ~hold_on;
    hold off;
end

end