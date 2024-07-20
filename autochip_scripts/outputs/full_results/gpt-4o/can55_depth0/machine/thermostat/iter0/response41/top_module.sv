module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Control the heater output
    assign heater = mode & too_cold;

    // Control the aircon output
    assign aircon = ~mode & too_hot;

    // Control the fan output
    assign fan = too_cold | too_hot | fan_on;

endmodule
