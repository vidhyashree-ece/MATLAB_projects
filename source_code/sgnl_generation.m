close all;
clear all;
disp('Generation of signal')
c=menu('generation of signal','sine wave','cosine wave','exponential signal','unit impulse','unit step','unit ramp');
switch(c)
    
    case 1
        t=0:0.01:pi;
        a=sin(2*pi*t);
        plot(t,a);
        xlabel('t-->');
        ylabel('amp-->');
        title('sine wave');
        
    case 2
        t=0:0.01:pi;
        a=cos(2*pi*t);
        plot(t,a);
        xlabel('t-->');
        ylabel('amp-->');
        title('cosine wave');
        
    case 3 
        t=0:10;
        x=input('Enter the Value');
        a=exp(-x*t);
        plot(t,a);
        xlabel('t-->');
        ylabel('amp-->');
        title('exponential wave');
        
    case 4
        t=-5:5
        a=[zeros(1,5),ones(1,1),zeros(1,5)];
        stem(t,a);
        xlabel('t-->');
        ylabel('amp-->');
        title('unit impulse');
        
    case 5 
        t=-5:5
        a=[zeros(1,5),ones(1,6)];
        stem(t,a);
        xlabel('t-->');
        ylabel('amp-->');
        title('unit step');
        
    case 6 
        t=0:5;
        plot(t,t);
        xlabel('t-->');
        ylabel('amp-->');
        title('unit ramp');
        
end
        
        
