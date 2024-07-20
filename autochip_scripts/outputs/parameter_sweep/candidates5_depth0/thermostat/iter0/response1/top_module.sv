module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

/* Internal wires */
wire fan_control;

/* Heater control */
assign heater = (mode == 1) && (too_cold || fan_on);
assign fan_control = (heater) ? 1 : fan_on;

/* Air conditioner control */
assign aircon = (mode == 0) && (too_hot || fan_on);
assign fan_control = (aircon) ? 1 : fan_control;

/* Fan control */
assign fan = fan_control;

endmodule
