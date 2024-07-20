module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Assign the fan output
    assign fan = fan_on || too_cold || too_hot;

    // Assign the heater and aircon outputs based on the mode and temperature inputs
    assign heater = (mode && too_cold);
    assign aircon = (!mode && too_hot);

endmodule
