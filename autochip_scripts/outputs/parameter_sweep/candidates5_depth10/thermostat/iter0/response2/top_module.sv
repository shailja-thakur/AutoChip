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
wire fan_auto;

// Fan Control
assign fan = (fan_on || (mode && ((too_cold && !too_hot) || (too_hot && !too_cold))));

// Heater Control
assign heater = (mode && too_cold) || fan_on;

// Air Conditioner Control
assign aircon = (mode && too_hot) || fan_on;

// Automatic Fan Control
assign fan_auto = (mode && (too_cold || too_hot));

endmodule
