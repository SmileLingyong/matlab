function [s,p] = fcircle(r)   
             % FCIRCLE calculate the area and perimeter of a circle of radii r
             % r       圆半径
             % s      圆面积
             % p      圆周长
             %2017年5月19日编
             s = pi*r*r;
             p = 2*pi*r;
     % 通过使用类似这样的语法调用该函数
     %         fcircle(1)
     %         [s,c]=fcircle(2)