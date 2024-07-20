module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Declare internal signals
    wire turn_fan_on;
    wire turn_heater_on;
    wire turn_aircon_on;

    // Determine if fan should be turned on
    assign turn_fan_on = (too_cold || too_hot || fan_on);

    // Determine if heater should be turned on
    assign turn_heater_on = (mode && too_cold);

    // Determine if air conditioner should be turned on
    assign turn_aircon_on = (!mode && too_hot);

    // Assign outputs
    assign fan = turn_fan_on;
    assign heater = turn_heater_on;
    assign aircon = turn_aircon_on;

endmodule
