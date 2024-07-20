module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Assign the fan control logic
    assign fan = too_cold | too_hot | fan_on;

    // Assign the heater control logic
    assign heater = mode & too_cold;

    // Assign the air conditioner control logic
    assign aircon = ~mode & too_hot;

endmodule
