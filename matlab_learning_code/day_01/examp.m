 function fout = charray(a,b,c)     %#ok
             if nargin == 1
                 fout = a;end
             if nargin == 2
                 fout = a+b;end
            if nargin == 3
                 fout = (a*b*c)/2;
            end