function gabout = gabor_fn(scale, theta)
% compute gabor filter according to the given parameters
% gabout: obtained gabor filter
phs = 0;
gamma = 1;
wins = floor(scale*2);
f = 1/(scale*2);
G = zeros(2*wins+1);

for x = -wins:wins
    for y = -wins:wins
        xPrime = x * cos(theta) + y * sin(theta);
        yPrime = y * cos(theta) - x * sin(theta);
        G(wins+x+1,wins+y+1) =1/(2*pi*scale*scale)*exp(-.5*((xPrime)^2+(yPrime*gamma)^2)/scale^2)*cos(2*pi*f*xPrime+phs);
    end
end

gabout=G;