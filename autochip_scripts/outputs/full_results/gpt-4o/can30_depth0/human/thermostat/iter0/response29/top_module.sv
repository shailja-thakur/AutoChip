module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Intermediate signals
    wire heater_on;
    wire aircon_on;

    // Heater control
    assign heater_on = mode & too_cold;

    // Air conditioner control
    assign aircon_on = ~mode & too_hot;

    // Main outputs
    assign heater = heater_on;
    assign aircon = aircon_on;

    // Fan control
    assign fan = heater_on | aircon_on | fan_on;

endmodule
