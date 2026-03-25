%{
====================================================================================================
SCRIPT NAME: Volume.m
AUTHOR: Elias Oliver
CLASS: MAE 4350.001 (Aerospace Vehicle Design I)
INITIAL VERSION: 03/24/2026
LAST REVISION: 03/24/2026
====================================================================================================
SCRIPT DESCRIPTION:
This script will create plots to inform the design desicions needed for the RCS thrusters.
====================================================================================================
AUXILIARY FUNCTIONS:
None.
====================================================================================================
ABBREVIATIONS:
None.
====================================================================================================
COMMENTS:
None.
====================================================================================================
%}

tic;
%[]Starts program timer.

clc;
%[]Clears command window.

clear;
%[]Clears variable workspace.

format('Compact');
%[]Sets the command window output to single-spaced output.

format('LongG');
%[]Sets the command window output to display 16 digits for double-precision variables.

close('All');
%[]Closes all figures.

fprintf('Begin Simulation...\n');
%[]Prints the formatted string on the command window.

fprintf('======================================================================\n');
%[]Prints the formatted string on the command window.

%% Analysis:



%% PRINT SIMULATION TIME:

fprintf('======================================================================\n');
%[]Prints the formatted string on the command window.

SimulationTime = toc;
%[s]Stops the program timer.

fprintf('Simulation Complete! (%0.3f seconds)\n',SimulationTime);
%[]Prints the simulation time on the command window.
%===================================================================================================