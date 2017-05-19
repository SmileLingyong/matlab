%   Publish Matlab Code
%   Created by LLY 
%   Time 2017.5.16

%%
t = 0:.1:pi*4;
y = sin(t);
plot(t,y);

% In each iteration of the for loop add an odd
% harmonic to y. As "k" increases, the output
% approximates a square wave with increasing accuracy.

for k = 3:2:9
    % Perform the following mathematical operation
    % at each iteration:
    y = y + sin(k*t)/k;
    % Display every other plot:
    if mod(k,4)==1
        display(sprintf('When k = %.1f',k));
        display('Then the plot is:');
        cla
        plot(t,y)
    end
end

%%
% Even though the approximations are constantly
% improving, they will never be exact because of the
% Gibbs phenomenon, or ringing.

