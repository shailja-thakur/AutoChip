module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    // Declare internal signal
    wire fan_control;

    // Turn on the fan if either too_cold or too_hot is high, or if fan_on is high
    assign fan_control = (too_cold || too_hot || fan_on);

    // Turn on the fan output based on fan_control signal
    assign fan = fan_control;

    // Turn on the heater output if mode is high and too_cold is high
    assign heater = (mode && too_cold);

    // Turn on the aircon output if mode is low and too_hot is high
    assign aircon = (!mode && too_hot);

endmodule
