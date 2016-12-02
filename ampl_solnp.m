%this is a test for using solnp
%alternative: prob=amplRead('powell.nl');
%get the path of the problems.
% Make sure we have file extension (always assume .nl)
clear all;
%fnames=data.mat;
%fnames={'arki0003.nl','arki0009.nl','bearing_200.nl','bearing_400.nl','camshape_1600.nl',...
 %      'camshape_6400.nl','clnlbeam.nl','cont_p.nl','cont5_1.nl','cont5_1_l.nl','cont5_2_1.nl',...
  %     'cont5_2_1_l.nl','cont5_2_2.nl','cont5_2_2_l.nl','cont5_2_3.nl','cont5_2_3_l.nl','cont5_2_4.nl',...
   %    'cont5_2_4_l.nl','corkscrw.nl','dirichlet40.nl','dirichlet80.nl','dirichlet120.nl','dtoc1nd.nl',...
    %   'dtoc2.nl','elec_200.nl','elec_400.nl','ex1_160.nl','NARX_CFy.nl','Weyl_m0.nl','WM_CFy.nl'};
 fnames={'powell2.nl','presolveelec_400.nl','presolvecorkscrw.nl','NARX_CFy.nl','WM_CFy.nl','Weyl_m0.nl','cont5_2_4_l.nl','cont_p.nl','corkscrw.nl','dirichlet40.nl',...
         'dirichlet80.nl','dirichlet120.nl','elec_200.nl','elec_400.nl'};
       %'arki0003.nl','arki0009.nl','bearing_200.nl','bearing_400.nl','camshape_1600.nl',...
       %'camshape_6400.nl','clnlbeam.nl','cont5_1.nl','cont5_1_l.nl','cont5_2_1.nl',...
       %'cont5_2_1_l.nl','cont5_2_2.nl','cont5_2_2_l.nl','cont5_2_3.nl','cont5_2_3_l.nl','cont5_2_4.nl',...
       %'dtoc1nd.nl',...
       %'dtoc2.nl','ex1_160.nl',};
result=zeros(11,length(fnames));
%filename='rosensuzuki.nl';
for i=1:1%length(fnames)
      filename=fnames{i};
    if(isempty(strfind(filename,'.nl')))
        filename = [filename '.nl'];
    end 
    % If filename includes absolute path, we can skip which
    if(~isempty(strfind(filename,':')))
       p = filename;
       %Check it exists
       if(~exist(filename,'file'))
            error('Cannot locate file %s!',filename);
       end
    else %Locate the full path to the file (must be on matlab path)
       p = which(filename);
    %Check it exists
        if(isempty(p))
            error('Cannot locate file %s!',filename);
        end
    end
    isNLP = 1; 
%load prob
    [prob,sizes] = asl('open',p,isNLP);
%save number of constraint and prob.x0
    ncon= sizes(2); %constraints
    pb=prob.x0;
    
    result(i,2)=length(pb);
    result(i,3)=size(pb,1);
    result(i,4)= sizes(1); %decision vars
    result(i,5)= sizes(2); %constraints
% nzJac   = sizes(3); %non zeros in jacobian
    result(i,6)= sizes(7); %nonlinear constraints
    result(i,7)= sizes(11); %nonlinear vars in cons
    result(i,8)= sizes(12); %nonlinear vars in obj
%-------------------storing featuers---------------
    tic;
    [p,jh,l,h,ic,iteration]=solnp(pb,0,0,0,0,ncon);
    toc;
    fprintf('finished problem No.[ %d ] using SOLNP\n', i);
     result(i,1)=i;
     result(i,9)=iteration;
     jhlength=size(jh,2);
     result(i,10)=jh(jhlength);
     %result(i,8)=info.resvec;
     result(i,11)=toc;
end