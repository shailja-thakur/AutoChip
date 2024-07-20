module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater is on only in heating mode (mode = 1) and if it is too cold (too_cold = 1)
    assign heater = mode && too_cold;
    
    // Air conditioner is on only in cooling mode (mode = 0) and if it is too hot (too_hot = 1)
    assign aircon = !mode && too_hot;
    
    // Fan is on if either the heater is on, the air conditioner is on, or the user requests the fan (fan_on = 1)
    assign fan = (heater || aircon || fan_on);

endmodule
