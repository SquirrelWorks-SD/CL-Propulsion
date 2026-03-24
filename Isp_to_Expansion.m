%{
====================================================================================================
SCRIPT NAME: Isp_to_Expansion.m
AUTHOR: Elias Oliver
CLASS: MAE 4350.001 (Aerospace Vehicle Design I)
INITIAL VERSION: 03/23/2026
LAST REVISION: 03/23/2026
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

%% WebPlotDigitizer:

OF = 6.94;
%[]Oxidizer to fuel mixture ratio. From Appendix B, Fig. B.20 and max vac Isp.

MM = 21.595;
%[kg/kmol]Molecular mass of combustion products at chamber, Fig. B.18 with the chosen OF.

T_c = 2752;
%[K]Flame temperature, Fig. B.17 with the chosen OF.

gamma = 1.185;
%[]Isentropic parameter at the throat, Fig. B.19 with the chosen OF.

%% Constants:

eta_c_star = 0.95;
%[]c* combustion efficiency, conservative estimate for equilibrium flow.

R = 8314 / MM;
%[J/kg-K]Exhaust gas constant.

c_star = (eta_c_star * sqrt(gamma * R * T_c)) / (gamma * (2 / (gamma + 1))^((gamma + 1) / (2 * gamma - 2)));
%[m/s]characteristic exhuast velocity.

P_a = 0;
%[Pa]Vacuum.

lambda = 0.95;
%[]Nozzle efficiency, conservative estimate.

g_0 = 9.80665;
%[m/s^2]Sea level acceleration due to gravity.

%% Variables:

n = 5;
%[]Number of values in the chamber pressure range.

m = 50;
%[]Number of values in the exit pressure range.

P_c = linspace(345000,1380000,n);
%[Pa]Creates a range of possible chamber pressures.

P_e = linspace(1000,175000,m);
%[Pa]Creates a range of possible exit pressures.

M_e = zeros(n,m);
%[]Allocates memory for the exit Mach number matrix.

epsilon = zeros(n,m);
%[]Allocates memory for the expansion ratio matrix.

I_sp = zeros(n,m);
%[]Allocates memory for the specific impulse matrix.

for i = 1:n

    for j = 1:m

        M_e(i,j) = sqrt((2 / (gamma - 1)) * ((P_c(i) / P_e(j))^((gamma - 1) / gamma) - 1));
        %[]Calculates exit Mach number.

        epsilon(i,j) = (1 / M_e(i,j)) * ((2 / (gamma + 1)) * (1 + ((gamma - 1) / 2) * M_e(i,j)^2))^((gamma + 1) / (2 * gamma - 2));
        %[]Calculates the expansion ratio.

        I_sp(i,j) = lambda * (((c_star * gamma) / (g_0) * sqrt((2 / (gamma - 1)) * (2 / (gamma + 1))^((gamma + 1) / (gamma - 1)) * (1 - (P_e(j) / P_c(i))^((gamma - 1) / gamma)))) + ((c_star * epsilon(i,j)) / (g_0 * P_c(i)) * (P_e(j) - P_a)));
        %[s]Calculates specific impulse.

    end

end

%% Make Plots:

Window = figure( ... %Opens a new window.
    'Color','w', ...%Makes the background color white.
    'Name','Plotting', ...%Adjust the name of the window.
    'NumberTitle','Off');%Turns the number title off.
%[]Opens a new window and adjusts its properties.

Axes = axes( ...
    'FontName','Arial', ...
    'FontSize',12, ...
    'FontWeight','Bold', ...
    'NextPlot','Add', ...
    'Parent',Window, ...
    'XLim',[0,100], ...
    'YLim', [150,300], ...
    'XTick',0:10:100, ...
    'YTick',150:50:300);
%[]Adds an axes to the specified window and adjusts its properties.

plot(epsilon(1,:),I_sp(1,:), ...
    'Color','k', ...
    'LineStyle','none', ...
    'Marker','.', ...
    'Parent',Axes);
%[]Adds a plot to the specified axes and adjusts its properties.

plot(epsilon(2,:),I_sp(2,:), ...
    'Color','k', ...
    'LineStyle','none', ...
    'Marker','.', ...
    'Parent',Axes);
%[]Adds a plot to the specified axes and adjusts its properties.

plot(epsilon(3,:),I_sp(3,:), ...
    'Color','k', ...
    'LineStyle','none', ...
    'Marker','.', ...
    'Parent',Axes);
%[]Adds a plot to the specified axes and adjusts its properties.

plot(epsilon(4,:),I_sp(4,:), ...
    'Color','k', ...
    'LineStyle','none', ...
    'Marker','.', ...
    'Parent',Axes);
%[]Adds a plot to the specified axes and adjusts its properties.

plot(epsilon(5,:),I_sp(5,:), ...
    'Color','k', ...
    'LineStyle','none', ...
    'Marker','.', ...
    'Parent',Axes);
%[]Adds a plot to the specified axes and adjusts its properties.

xlabel(Axes, 'Expansion ratio, \epsilon');
%[]Sets the x-axis label.

ylabel(Axes, 'Specific Impulse (s), I_{sp}');
%[]Sets the y-axis label.

%% PRINT SIMULATION TIME:

fprintf('======================================================================\n');
%[]Prints the formatted string on the command window.

SimulationTime = toc;
%[s]Stops the program timer.

fprintf('Simulation Complete! (%0.3f seconds)\n',SimulationTime);
%[]Prints the simulation time on the command window.
%===================================================================================================