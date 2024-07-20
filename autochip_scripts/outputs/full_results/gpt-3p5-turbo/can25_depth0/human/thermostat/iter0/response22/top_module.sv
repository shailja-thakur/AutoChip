module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Internal signal to control the fan
wire fan_control;

// Determine whether the heater should be on
assign heater = (mode && too_cold && !too_hot) || fan_on;

// Determine whether the air conditioner should be on
assign aircon = (!mode && too_hot && !too_cold) || fan_on;

// Determine whether the fan should be on
assign fan_control = (heater || aircon || fan_on);
assign fan = fan_control;

endmodule
