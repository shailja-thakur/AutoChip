module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Create a signal for fan control
wire fan_control;

// Logic for determining when to turn on the heater, air conditioner, and fan
assign heater = (mode == 1) && too_cold && !fan_on;
assign aircon = (mode == 0) && too_hot && !fan_on;
assign fan_control = fan_on || heater || aircon;
assign fan = fan_control;

endmodule
