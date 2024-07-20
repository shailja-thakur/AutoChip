module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Logic for turning on and off the heater, air conditioner, and fan
assign heater = mode && too_cold && !fan_on;
assign aircon = !mode && too_hot && !fan_on;
assign fan = (heater || aircon || fan_on) ? 1'b1 : 1'b0;

endmodule
