%Fixes data to use drivingscenario class
function [uniqwp,uniqvel]=dupli(waypoint,velocity)
waypoint=round(waypoint);
velocity=round(velocity);
uniqwp=[];
uniqvel=[];
 y = zeros(size(waypoint));
[uniqwp,ia,ic]=unique(waypoint);
  for i=1:1:length(ia)
    uniqvel=[uniqvel,velocity(ia(i))];
       
 end
uniqwp=uniqwp(3:end);
uniqvel=uniqvel(3:end);
end

