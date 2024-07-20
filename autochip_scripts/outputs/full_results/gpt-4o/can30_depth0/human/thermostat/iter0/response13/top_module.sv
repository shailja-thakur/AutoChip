module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // When in heating mode and it's too cold, turn on the heater.
    assign heater = mode && too_cold;
    
    // When in cooling mode and it's too hot, turn on the air conditioner.
    assign aircon = ~mode && too_hot;
    
    // The fan should be on if the heater or air conditioner is on, or if the user requested the fan to be on.
    assign fan = heater || aircon || fan_on;

endmodule
