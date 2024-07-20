module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Assign the fan output based on inputs
    assign fan = (fan_on || too_cold || too_hot);

    // Assign the heater output based on inputs
    assign heater = (mode && too_cold);

    // Assign the aircon output based on inputs
    assign aircon = (mode && too_hot);

endmodule
