/*
Use this script to perform an automatic PID parameters tuning. You should run this script first before running the running_script.sce

The code optimizes for Kp,Ki,Kd,Tc(The derivative time constant),Ko(The weight on the overshoot cost function.

The overall cost function is: Integral of squared error over time + Ko*(the ratio of error to reference)

The number of iterations per generation is: Number of generation  ^ The number of design variables

*/

clear;clc

//define the objective function where the design variables are the PID gains
function cost = objective_func(params)
       
    //Assign the params to their optimal values in the workspace
    global Kp_opt
    global Ki_opt
    global Kd_opt
    global Tc_opt
    global Ko_opt
    Kp_opt = params(1)
    Ki_opt = params(2)
    Kd_opt = params(3)
    Tc_opt = params(4)
    Ko_opt = params(5)
    
    //Set the gains that will be sent to the Xcos simulator
    global time
    global Kp
    global Ki
    global Kd
    global Tc_base
    global Ko_base
    global PID_error
len_time = length(time)
Kp.time = time
Kp.values = Kp_opt*ones(len_time,1)
Ki.time = time
Ki.values = Ki_opt*ones(len_time,1)
Kd.time = time
Kd.values = Kd_opt*ones(len_time,1)
Tc_base.time = time
Tc_base.values = Tc_opt*ones(length(time),1)
Ko_base.time = time
Ko_base.values = Ko_opt*ones(length(time),1)
    
    //Simulate the Xcos diagram
    importXcosDiagram('DC_motor.zcos')
    typeof(scs_m) //The diagram data structure
    [Info, status] = xcos_simulate(scs_m, 4)
    
    //calculate the mean square error MSE
    squared_error = PID_error.values
    sys_time = PID_error.time
    cost = sum(squared_error) //sum_of_sqaure_error    
disp(cost)
    //
    
endfunction



//define the global gains to sent to Xcos
global Kp
global Ki
global Kd
//Define global optimal values
global Kp_opt
global Ki_opt
global Kd_opt
//Initialize these optimal values
Kp_opt=0
Ki_opt=0
Kd_opt=0

//Define the gains in a structure that aligns with Xcos
global time
sim_time = 20//THIS SHOULD BE CHANGED EACH TIME you change simulation time
time = (0:0.1:sim_time)'
//len_time = length(time)
//Kp.time = time
//Kp.values = Kp_opt*ones(len_time,1)
//Ki.time = time
//Ki.values = Ki_opt*ones(len_time,1)
//Kd.time = time
//Kd.values = Kd_opt*ones(len_time,1)


//Define the global derivative time constant to be sent to Xcos
global Tc_base
//Define the global optimal derivative time constant
global Tc_opt
Tc_opt = 1e-1


//Define the global derivative time constant to be sent to Xcos
global Ko_base
//Define the global optimal derivative time constant
global Ko_opt
Ko_opt = 1


//Define the PID error
global PID_error


//////////////////////////////////
//Testing The objective function
//test = [1,2,3]
//f = objective_func(test);
//////////////////////////////////////


// Define the genetic algorithm parameters
PopSize     = 100;
Proba_cross = 0.7;
Proba_mut   = 0.1;
NbGen       = 1;
NbCouples   = 110;
Log         = %T;


// Parameters to control the initial population.

ga_params = init_param();
ga_params = add_param(ga_params,'minbound',[0;0;0;0;1]);
ga_params = add_param(ga_params,'maxbound',[100;100;100;100;100]);
ga_params = add_param(ga_params,'dimensions',5);

// Run the genetic algorithm optimization
[pop_opt, fobj_pop_opt] = optim_ga(objective_func,PopSize,NbGen,Proba_mut,Proba_cross,Log,ga_params)

//Run the simulation again with the optimized parameters
opt = [Kp_opt,Ki_opt, Kd_opt, Tc_opt, Ko_opt]

// Load the Xcos diagram containing the plant and PID controller blocks
//importXcosDiagram('fuel_cell.zcos')
//typeof(scs_m) //The diagram data structure
//[Info, status] = xcos_simulate(scs_m, 4)


