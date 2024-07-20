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
    wire heater_on;
    wire aircon_on;

    // Heater control logic
    assign heater_on = (mode == 1) && too_cold;

    // Air conditioner control logic
    assign aircon_on = (mode == 0) && too_hot;

    // Heater output
    assign heater = heater_on;

    // Air conditioner output
    assign aircon = aircon_on;

    // Fan output: It should be on if either the heater or aircon is on, or if fan_on is set by the user
    assign fan = heater_on || aircon_on || fan_on;

endmodule
