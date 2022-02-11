function p = findzero(f, a, b, tol)
% Print header
fprintf(' n a b p f(p) \n'); 
fprintf('-----------------------------------------------------------\n'); 
w = 1;
for n = 1:100
	p = a + w*f(a) * (a - b) / (f(b) - w*f(a)); 	fprintf('%2d %12.8f %12.8f %12.8f %12.8f\n', n, a, b, p, f(p));
	 if f(p) * f(b) > 0 
		w = 1/2; 
	else 
		w = 1; 
		a = b; 
	end 
	b = p; 
	if abs(b-a) < tol | abs(f(p)) < tol, break; end
end


function p = findmanyzeros(f, a, b, n, tol)
x = a + (b-a)*(0:n)/n;
fx = f(x); 
p = [];
for i = 1:n
	if sign(fx(i)) ~= sign(fx(i+1))
		p(end+1) = findzero(f, x(i), x(i+1), tol);
	end 
end 



for fcn = 1:2
	% Define function and derivative
	if fcn == 1
		f = @(x) sin(x) - exp(-x);
		df = @(x) cos(x) + exp(-x);
	elseif fcn == 2
		f = @(x) sin(x.^2)./(10+x.^2) - exp(-x/10)/50;
		df = @(x) 2*x.*cos(x.^2)./(10+x.^2) ...
			- 2*sin(x.^2).*x./(10+x.^2).^2 + exp(-x/10)/500; 
end 
% Solve for zeros and extrema
    p = findmanyzeros(f, 0, 10, 50, 1e-10);
    dp = findmanyzeros(df, 0, 10, 50, 1e-10);
% Create plot 
x = linspace(0, 10, 1000); plot(x, f(x), x, 0*x, p, 0*p, 'ko', dp, f(dp), 'm^') 
legend(sprintf('f_%d(x)', fcn), 'y=0', 'Zeros', 'Extrema', ... 
           'location', 'southeast')
grid on
% Create vector graphics
set(gcf, 'paperpos',[0,0,6,4.5])
filename = sprintf('pa14fig%d.eps', fcn);
print('-depsc', filename);
end 


