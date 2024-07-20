module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Heater should be on if mode is heating and it's too cold
    assign heater = mode && too_cold;
    
    // Air conditioner should be on if mode is cooling and it's too hot
    assign aircon = ~mode && too_hot;
    
    // Fan should be on if heater or air conditioner is on or if fan_on is requested
    assign fan = heater || aircon || fan_on;

endmodule
