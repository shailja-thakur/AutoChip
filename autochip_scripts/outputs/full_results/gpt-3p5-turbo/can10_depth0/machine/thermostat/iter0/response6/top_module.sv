module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

    wire fan_control;

    assign fan_control = (too_cold || too_hot || fan_on);

    assign fan = fan_control;
    assign heater = (mode && too_cold);
    assign aircon = (!mode && too_hot);

endmodule
