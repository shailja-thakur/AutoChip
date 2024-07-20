module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Control fan output
    assign fan = fan_on | too_cold | too_hot;
    
    // Control heater output
    assign heater = mode & too_cold;
    
    // Control air conditioner output
    assign aircon = ~mode & too_hot;

endmodule
