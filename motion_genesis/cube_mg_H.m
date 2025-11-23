function [t,VAR,Output] = cube_mg_H
%===========================================================================
% File: cube_mg_H.m created Nov 20 2025 by MotionGenesis 6.5.
% Portions copyright (c) 2009-2025 Motion Genesis LLC.  Rights reserved.
% MotionGenesis Student Licensee: Charlie Lambert. (until September 2028).
% This MotionGenesis Student license is granted the right to use this code
% only until September 2028, only for legal student-academic (non-professional) purposes,
% and limited to their coursework completion at their accredited school.
% All use of this code is specifically limited to this student licensee.
% No rights are extended for other purposes or to anyone but the licensee.
% This copyright notice must appear in all uses of this code.
%===========================================================================
% The software is provided "as is", without warranty of any kind, express or    
% implied, including but not limited to the warranties of merchantability or    
% fitness for a particular purpose. In no event shall the authors, contributors,
% or copyright holders be liable for any claim, damages or other liability,     
% whether in an action of contract, tort, or otherwise, arising from, out of, or
% in connection with the software or the use or other dealings in the software. 
%===========================================================================
eventDetectedByIntegratorTerminate1OrContinue0 = [];
H=0; S=0; HDt=0; qXDt=0; qYDt=0; qZDt=0; SDt=0; HDDt=0; qXDDt=0; qYDDt=0; qZDDt=0; SDDt=0;
PDDt=0;


%-------------------------------+--------------------------+-------------------+-----------------
% Quantity                      | Value                    | Units             | Description
%-------------------------------|--------------------------|-------------------|-----------------
CIX                             =  0.011496398;            % kg*m^2              Constant
CIY                             =  0.011603443;            % kg*m^2              Constant
CIZ                             =  0.011600232;            % kg*m^2              Constant
CX                              =  0.072113;               % m                   Constant
CY                              =  0.071399;               % m                   Constant
CZ                              =  0.071467;               % m                   Constant
g                               =  9.81;                   % m/s^2               Constant
mC                              =  0.84392696;             % kg                  Constant
mR                              =  0.04711499;             % kg                  Constant
RI                              =  0.000173232;            % kg*m^2              Constant
RX                              =  0.076;                  % m                   Constant
RY                              =  0.076;                  % m                   Constant
RZ                              =  0.007789;               % m                   Constant

P                               =  0.0;                    % UNITS               Initial Value
PDt                             =  0.0;                    % UNITS               Initial Value

tInitial                        =  0.0;                    % second              Initial Time
tFinal                          =  10.0;                   % second              Final Time
tStep                           =  0.05;                   % second              Integration Step
printIntScreen                  =  1;                      % 0 or +integer       0 is NO screen output
printIntFile                    =  1;                      % 0 or +integer       0 is NO file   output
absError                        =  1.0E-05;                %                     Absolute Error
relError                        =  1.0E-08;                %                     Relative Error
%-------------------------------+--------------------------+-------------------+-----------------


VAR = SetMatrixFromNamedQuantities;
[t,VAR,Output] = IntegrateForwardOrBackward( tInitial, tFinal,