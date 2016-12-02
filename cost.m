%cost function of matlab solnp
%need to add input if linear and nonlinear constraint numbers and orderts
%try only consider nonlinear programming function without linear
function[f]=cost(x, par,ncon)
%disp('Major-iteration:'); 
%par;
%f is a column vector: f(1) is the value of the objective function evaluated at x,
f(1) = asl('fun',x);
%f(1)=amplfunc(x,2);
%linear constraint value
%mLin=amplcost(2);
%if mLin~=0,
%f(2:1+mLin)=prob.A*x;
%f(2+mLin:1+mLin+mNonLin) = ampl_c(x,prob);
%f(2+mLin:1+mLin+mNonLin) = amplfunc(x,3);
%else
%f(2+mLin:1+mLin+mNonLin) = amplfunc(x,3);
f(2:1+ncon) = asl('con',x);
%end;
%nonlinear constraint value
%f(2+nec:nc) = ampl_c(x, Prob)
%f(1)=exp(x(1)*x(2)*x(3)*x(4)*x(5));
%f(2)=x(1)^2+x(2)^2+x(3)^2+x(4)^2+x(5)^2-10;
%f(3)=x(2)*x(3)-5*x(4)*x(5);
%f(4)=x(1)^3+x(2)^3+1;
f=f';
return
%find the linear and nonlinear boundary in the prob set