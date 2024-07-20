module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    wire fan_control;
    
    assign fan_control = fan_on | too_cold | too_hot;
    
    assign fan = fan_control;
    
    // Turn on heater if mode is high and too_cold is high
    assign heater = mode & too_cold;
    
    // Turn on aircon if mode is low and too_hot is high
    assign aircon = ~mode & too_hot;
    
endmodule
