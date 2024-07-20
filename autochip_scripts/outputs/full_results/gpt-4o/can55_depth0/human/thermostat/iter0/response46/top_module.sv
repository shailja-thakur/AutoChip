module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Determine heater operation in heating mode
    assign heater = mode & too_cold;
    
    // Determine air conditioner operation in cooling mode
    assign aircon = ~mode & too_hot;
    
    // Determine fan operation regardless of mode
    assign fan = heater | aircon | fan_on;

endmodule
