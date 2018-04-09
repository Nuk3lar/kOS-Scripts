CLEARSCREEN.
HUDTEXT("Initiating Launch", 1, 2, 20, GREEN, FALSE).
WAIT 3.
RCS ON.
SAS OFF.
HUDTEXT("RCS enabled...", 1, 2, 20, YELLOW, FALSE).
wait 1.
HUDTEXT("SAS disabled...", 1, 2, 20, YELLOW, FALSE).
wait 0.9.
lock throttle to 1.
//This is our countdown loop, which cycles from 20 to 0
HUDTEXT("Countdown initiated!", 3, 2, 25, RED, FALSE).
FROM {local countdown is 5.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    HUDTEXT("..." + countdown, 1, 2, 20, GREEN, FALSE).
    WAIT 1. // pauses the script here for 1 second.
}
HUDTEXT("Launch!", 3, 2, 25, RED, FALSE).
WHEN MAXTHRUST = 0 THEN {
    WAIT 0.5.
    STAGE.
    PRESERVE.
}
UNTIL SHIP:Apoapsis > 95000 {
    wait until altitude > 500.
    HUDTEXT("Pitching to 88 Degrees", 3, 2, 20, GREEN, FALSE).
    lock steering to heading(90,88).
    wait until altitude > 1000.
    lock steering to heading(90,80).
    HUDTEXT("Pitching to 80 Degrees", 3, 2, 20, GREEN, FALSE).
    wait 1.2.
    lock steering to heading(90,70).
    HUDTEXT("Pitching to 70 Degrees", 3, 2, 20, GREEN, FALSE).
    wait 1.2.
    lock steering to heading(90,60).
    HUDTEXT("Pitching to 60 Degrees", 3, 2, 20, GREEN, FALSE).
    wait until altitude > 5000.
    lock steering to heading(90,50).
    HUDTEXT("Pitching to 50 Degrees", 3, 2, 20, GREEN, FALSE).
    wait 1.2.
    lock steering to heading(90,45).
    HUDTEXT("Pitching to 45 Degrees", 3, 2, 20, GREEN, FALSE).
    wait until altitude > 14000.
    lock steering to heading(90,35).
    HUDTEXT("Pitching to 35 Degrees", 3, 2, 20, GREEN, FALSE).
    wait 1.2.
    lock steering to heading(90,25).
    HUDTEXT("Pitching to 25 Degrees", 3, 2, 20, GREEN, FALSE).
    
    wait until altitude > 17000.
    lock steering to heading(90,22).
    HUDTEXT("Pitching to 22 Degrees", 3, 2, 20, GREEN, FALSE).
    wait 1.2.
    lock steering to heading(90,20).
    HUDTEXT("Pitching to 20 Degrees", 3, 2, 20, GREEN, FALSE).
    wait 4.
    
    HUDTEXT("Gravity turn complete", 3, 2, 20, RED, FALSE).
    HUDTEXT("Throttle down", 3, 2, 20, YELLOW, FALSE).
    lock throttle to 0.6.
    lock steering to heading(90,20).
    HUDTEXT("Pitching...", 5, 2, 20, YELLOW, FALSE).
    if ship:Apoapsis < 95000 {
        HUDTEXT("Boosting Apoapsis to > 95km", 5, 2, 25, YELLOW, FALSE).
        UNTIL SHIP:Apoapsis > 95000 {
            lock throttle to 0.6. 
            lock steering to heading(90,17).
            } 
    } else if ship:Apoapsis > 95000 {
        lock steering to heading(90,29).
    }
}.
HUDTEXT("Boosting Complete", 3, 2, 22, RED, FALSE). 
LOCK THROTTLE TO 0.
wait until ship:altitude > 72000.
FOR module IN SHIP:MODULESNAMED("ModuleProceduralFairing") { // Stock and KW Fairings

// and deploys them
module:DOEVENT("deploy").
HUDTEXT("Faring deployed", 3, 2, 20, GREEN, FALSE).


}.
UNTIL ETA:Apoapsis < 5 {
    lock steering to heading(90,3).
}
print("Peforming orbit burn to periapsis 80km").
UNTIL ship:periapsis > 80000 {
    sas off.
    lock steering to heading(90,3).
    lock THROTTLE to 1.
}
HUDTEXT("Orbit burn complete, switching to manual", 3, 2, 20, GREEN, FALSE).
HUDTEXT("Apoapsis: "+(round((round(ship:Apoapsis,1)/1000),1)+"km"), 3, 2, 20, GREEN, FALSE).
HUDTEXT("Periapsis: "+(round((round(ship:periapsis,1)/1000),1)+"km"), 3, 2, 20, GREEN, FALSE).
lock throttle to 0.
//This sets the user's throttle setting to zero to prevent the throttle
//from returning to the position it was at before the script was run.
SAS ON.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.