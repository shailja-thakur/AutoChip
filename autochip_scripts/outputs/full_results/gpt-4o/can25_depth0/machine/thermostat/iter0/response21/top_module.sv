module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Control for fan
    assign fan = too_cold | too_hot | fan_on;
    
    // Control for heater
    assign heater = mode & too_cold;
    
    // Control for aircon
    assign aircon = ~mode & too_hot;

endmodule
