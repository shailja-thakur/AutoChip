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
    wire fan_ctrl;

    // Control the fan
    assign fan_ctrl = fan_on || too_cold || too_hot;
    assign fan = fan_ctrl;

    // Control the heater
    assign heater = mode && too_cold;

    // Control the air conditioner
    assign aircon = !mode && too_hot;

endmodule
