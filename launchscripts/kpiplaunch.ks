print "STARTING UP".
WAIT 0.2.
RCS ON.
SAS ON.
print "RCS ACTIVATED".
lock throttle to 1.



//This is our countdown loop, which cycles from 10 to 0
PRINT "LAUNCHING IN:".
FROM {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 1. // pauses the script here for 1 second.
}

print "Launching".
WHEN MAXTHRUST = 0 THEN {
    WAIT 0.5.
    PRINT "Autostaging".
    STAGE.
    PRESERVE.
}
WAIT UNTIL altitude > 400.
lock steering to UP + R(0,10,180).
WAIT UNTIL altitude > 5000.
lock steering to UP + R(0,15,180).
wait 0.9.
lock steering to UP + R(0,20,180).
WAIT UNTIL altitude > 13000.
lock steering to UP + R(0,25,180).
wait 0.9.
lock steering to UP + R(0,30,180).
wait 0.9.
lock steering to UP + R(0,35,180).
WAIT UNTIL altitude > 17000.
lock steering to UP + R(0,40,180).
wait 0.9.
lock steering to UP + R(0,45,180).
WAIT UNTIL altitude > 25000.
lock steering to UP + R(0,50,180).
WAIT UNTIL altitude > 40000.
lock steering to UP + R(0,55,180).
wait 0.9.
lock steering to UP + R(0,60,180).
wait 0.9.
WAIT UNTIL altitude > 55000.
lock steering to UP + R(0,65,180).
wait 0.9.
lock steering to UP + R(0,70,180).
wait 0.9.
WAIT UNTIL ship:apoapsis > 85000.
print "Apoapsis above 85km reached".
LOCK THROTTLE TO 0.
WAIT UNTIL ship:altitude > 84700.
UNTIL ship:periapsis > 80000 {
    print("Peforming orbit burn").
    lock THROTTLE to 1.
}
    


lock throttle to 0.
//This sets the user's throttle setting to zero to prevent the throttle
//from returning to the position it was at before the script was run.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.