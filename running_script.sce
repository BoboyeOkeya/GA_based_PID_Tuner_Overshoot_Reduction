/*

This script is for use in running the simulation after obtaining the estimated values

    */

    //[Kp_opt,Ki_opt, Kd_opt, Tc_opt, Ko_opt] = [ 92.75148   76.409035   78.297362   33.819354   9.6865942]

    //Define the optimized values
//    opt = [[92.97064152384434], [61.23846252995821], [51.51962989954858], [13.53362173527123], [9.421186571142776]]



//    opt = [[92.97064152384434], [61.23846252995821], [51.51962989954858], [13.53362173527123], [9.421186571142776]]
//    opt = [[93.45193073447317], [64.23853792321708], [50.80420085505639], [12.25077811703178], [9.525785200514662]]
//    opt = [[92.97433750469892], [77.18815903705347], [78.45276500219391], [33.10764848188437], [9.644239788706154]]
//    Kp_opt = opt(1)
//    Ki_opt = opt(2)
//    Kd_opt = opt(3)
//    Tc_opt = opt(4)
//    Ko_opt = opt(5)

//    Kp_opt = 60.986664
//    Ki_opt = 93.425059
//    Kd_opt = 61.766639
//    Tc_opt = 47.252524
//    Ko_opt = 86.084788


//    Kp_opt = 23.188862 
//    Ki_opt = 72.243959 
//    Kd_opt = 70.472372
//    Tc_opt = 14.986545
//    Ko_opt = 20.315633

    sim_time = 30//THIS SHOULD BE CHANGED EACH TIME you change simulation time
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

