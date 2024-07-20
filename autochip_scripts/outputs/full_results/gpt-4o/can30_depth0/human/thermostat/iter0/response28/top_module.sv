module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Signals for heater and air conditioner control
    wire heater_control, aircon_control;
    
    // Heating mode (mode = 1)
    assign heater_control = mode & too_cold;
    assign aircon_control = ~mode & too_hot;
    
    // Turn on the fan if heater or air conditioner is on, or if the user requests the fan to be on
    assign fan = fan_on | heater_control | aircon_control;
    
    // Heater is on only in heating mode and when it's too cold
    assign heater = heater_control;
    
    // Air conditioner is on only in cooling mode and when it's too hot
    assign aircon = aircon_control;

endmodule
