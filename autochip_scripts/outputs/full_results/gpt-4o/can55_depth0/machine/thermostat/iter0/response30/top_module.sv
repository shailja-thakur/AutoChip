module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    // Internal signals
    wire heating_mode;
    wire cooling_mode;
    
    // Determine if we are in heating or cooling mode based on mode input
    assign heating_mode = mode;
    assign cooling_mode = ~mode;
    
    // Control heater
    assign heater = heating_mode & too_cold;
    
    // Control air conditioner
    assign aircon = cooling_mode & too_hot;
    
    // Control fan
    assign fan = too_cold | too_hot | fan_on;

endmodule
