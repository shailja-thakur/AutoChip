module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Control the heater based on mode and temperature
    assign heater = (mode && too_cold) ? 1 : 0;

    // Control the air conditioner based on mode and temperature
    assign aircon = (!mode && too_hot) ? 1 : 0;

    // Control the fan based on heater, air conditioner or user request
    assign fan = (heater || aircon || fan_on) ? 1 : 0;

endmodule
