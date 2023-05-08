/*

This script is for use in running the simulation after obtaining the estimated values

    */

    Kp_opt = opt(1)
    Ki_opt = opt(2)
    Kd_opt = opt(3)
    Tc_opt = opt(4)
    Ko_opt = opt(5)


    sim_time = 20//THIS SHOULD BE CHANGED EACH TIME you change simulation time
    time = (0:0.1:sim_time)'
    len_time = length(time)
    Kp.time = time
    Kp.values = Kp_opt*ones(len_time,1)
    Ki.time = time
    Ki.values = Ki_opt*ones(len_time,1)
    Kd.time = time
    Kd.values = Kd_opt*ones(len_time,1)
    Tc_base.time = time
    Tc_base.values = Tc_opt*ones(len_time,1)
    Ko_base.time = time
    Ko_base.values = Ko_opt*ones(len_time,1)

    //Simulate the Xcos diagram
    importXcosDiagram('DC_motor.zcos')
    typeof(scs_m) //The diagram data structure
    [Info, status] = xcos_simulate(scs_m, 4)

