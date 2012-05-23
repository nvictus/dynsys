function h = vectorfield1d(ode, coords, x, t, varargin)

if ~exist('ccoords','var') || isempty(x)
    x = linspace(min(coords), max(coords), 100);
end
if ~exist('t','var') || isempty(t)
    t = 0;
end

% coarse-grained for arrows
coords = coords(:);
m  = length(coords);
arrows = zeros(m,1);
for i = 1:m
    arrows(i) = ode(t, coords(i), varargin{:});
end

% fine-grained for curve plotting
n = length(x);
xdot = zeros(n,1);
for i = 1:n
    xdot(i) = ode(t, x(i), varargin{:});
end

% try to estimate position of a fixed point when there is a zero crossing
xeq = [];
neq = 0;
for i = 1:n-1
    if xdot(i)*xdot(i+1) < 0
        [xp,~,exitflag] = fzero(@(x)ode(t,x,varargin{:}), [x(i); x(i+1)]);
        if exitflag
            xeq = [xeq; xp]; %#ok
            neq = neq + 1;
        end
    elseif xdot(i) == 0
         xeq = [xeq; xdot(i)]; %#ok
         neq = neq + 1;
    end
end
 
ax1 = gca();
h(1) = plot(x, xdot, 'r');
lim = max(abs(xdot));
set(ax1, 'YLim', [-lim lim]);
ylabel('dx/dt');
xlabel('x');

ax2 = axes('Position', get(ax1,'Position'));
hold on;

% change this to plot using triangle markers pointing left and right
% instead of quiver arrows. ???
% pos = arrows>0;
% neg = arrows<0;
% plot(coords(neg), zeros(sum(neg),1), '<', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'None');
% plot(coords(pos), zeros(sum(pos),1), '>', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'None');

h(2) = quiver(ax2, coords,zeros(m,1), arrows,zeros(m,1), 0.5, 'k', 'LineWidth', 1); 
h(3) = plot(xeq, zeros(neq,1), 'ko', 'MarkerFaceColor', 'k'); 
hold off;
lim = max(abs(diff(coords)));
set(ax2, 'YLim', [-lim lim]); % largest arrowhead has width related to distance between coords
set(ax2, 'XTick', [], 'YTick', [], 'Box', 'off');
set(ax2, 'Color', 'None');





