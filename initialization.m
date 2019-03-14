clear all;
%Author Ajinkya Krishnakumar 2019 
% Headaway constant
    h = 0.9;

% Lead vehicle driveline dynamics constant
    tau0 = 0.1;

% Ideal following vehicles 1-5 driveline dynamics constants
    tau1 = 0.5;
    tau2 = 0.7;
    tau3 = 0.3;
    tau4 = 0.7;
    tau5 = 0.9;
    
% Ideal vehicle 1-5 engine performance loss constant
    Lambda1 = 0.5;
    Lambda2 = 0.7;
    Lambda3 = 0.75;
    Lambda4 = 0.7;
    Lambda5 = 0.7;
    
 %Control data
 
 Kp=1.5;
 Kd=1.2;
 
 %Run the simulation of ACC
 sim('ACCnovis.slx')
 [carleadwp,carleadv]=dupli(carleadwp,carleadv);
 [car2wp,car2v]=dupli(car2wp,car2v);
 [car3wp,car3v]=dupli(car3wp,car3v);
 [car4wp,car4v]=dupli(car4wp,car4v);
 [car5wp,car5v]=dupli(car5wp,car5v);
 [car6wp,car6v]=dupli(car6wp,car6v);
 %Fixing data from the simulation
 carleadwp=[carleadwp,zeros(length(carleadwp),1),zeros(length(carleadwp),1)];
 car2wp=[car2wp,zeros(length(car2wp),1),zeros(length(car2wp),1)];
 car3wp=[car3wp,zeros(length(car3wp),1),zeros(length(car3wp),1)];
 car4wp=[car4wp,zeros(length(car4wp),1),zeros(length(car4wp),1)];
 car5wp=[car5wp,zeros(length(car5wp),1),zeros(length(car5wp),1)];
 car6wp=[car6wp,zeros(length(car6wp),1),zeros(length(car6wp),1)];
 
 
 %Scenario Display
sc = drivingScenario('SampleTime',0.1','StopTime',600);
roadcenters = [2200 0 0; 0 0 0];
road(sc,roadcenters)
rbdry = roadBoundaries(sc);
car6 = vehicle(sc,'Position',[0,0,0],'Length',3,'Width',2,'Height',1.6);
car5 = vehicle(sc,'Position',[4,0,0],'Length',3,'Width',2,'Height',1.6);
car4 = vehicle(sc,'Position',[8,0,0],'Length',3,'Width',2,'Height',1.6);
car3 = vehicle(sc,'Position',[12,0,0],'Length',3,'Width',2,'Height',1.6);
car2 = vehicle(sc,'Position',[16,0,0],'Length',3,'Width',2,'Height',1.6);
carlead = vehicle(sc,'Position',[20,0,0],'Length',3,'Width',2,'Height',1.6);







%Assign Trajectory for the platoon
trajectory(carlead, carleadwp,carleadv);
trajectory(car2, car2wp,car2v);
trajectory(car3, car3wp,car3v);
trajectory(car4, car4wp,car4v);
trajectory(car5, car5wp,car5v);
trajectory(car6, car6wp,car6v);
bepPlot = birdsEyePlot('XLim',[-50 50],'YLim',[-20 20]);
outlineplotter = outlinePlotter(bepPlot);
laneplotter = laneBoundaryPlotter(bepPlot);
legend('off')
chasePlot(car4,'Centerline','on')
while advance(sc)
    rb = roadBoundaries(carlead);
    [position,yaw,length,width,originOffset,color] = targetOutlines(carlead);    
    plotLaneBoundary(laneplotter,rb)
    plotOutline(outlineplotter,position, yaw, length, width, ...
        'OriginOffset',originOffset,'Color',color)
    axis off
    pause(0.01)
end