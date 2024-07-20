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
    wire activate_heater;
    wire activate_aircon;
    wire activate_fan;

    // Heater control logic
    assign activate_heater = (mode == 1) && (too_cold == 1);
    assign heater = activate_heater;

    // Air conditioning control logic
    assign activate_aircon = (mode == 0) && (too_hot == 1);
    assign aircon = activate_aircon;

    // Fan control logic
    assign activate_fan = (fan_on == 1) || (heater == 1) || (aircon == 1);
    assign fan = activate_fan;

endmodule
