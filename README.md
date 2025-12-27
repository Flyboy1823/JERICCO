# JERICCO PROJECT

This repository details contributions I made to the JERICCO project during 2022-2024 as part of the Controls Team, the head of the Mission and Orbit Team and the Head of the Systems Engineering Team.   
JERICCO (Joint-EffoRt Innovative Cubesat for Cislunar Orbit),
is a student designed lunar CubeSat-satellite. 
It was developed in a cooperative effort between the
Technion- Israel Institute of Technology and IAI - Israel Aerospace Industries. 
The project was planned to launch to low lunar orbit in the late 2026 to complete a scientific mission,
however the project was canceled due to budget constraints.
The following repository includes the last FDR report for the project as well as code form several teams.

The Controls Team:
Mainly worked on detumbling and pointing for thrust.  The team used MATLAB and Simulink to code and simulate
a PID controller for a tetrahetridal-shapped reaction wheel configuration.  

Mission and Orbit Design Team:
The team was given the responsibilty of creating a long last orbit as close to the lunar surface as possible.
Using STK iterations, the team managed to autmoate thrust (for specific Dawn thrustters) that minimizes the necessary
delta v and keeps the satallite in a relativly ciruclar orbit at an altitude of roughly 200 km above the lunar surface.  
The final fuel budget was simulated to last 5 years.

Systems Engineering Team
As the main systesm engineer, a ConOps was designed and written.
This ConOps designed the various modes and flags that the CubeSat would be prevy to.
Furthermore, the ConOps was ment to allow for faster collaboration between all other teams.
