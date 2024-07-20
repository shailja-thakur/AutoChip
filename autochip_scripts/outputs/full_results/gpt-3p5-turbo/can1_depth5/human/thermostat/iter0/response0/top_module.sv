module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Heater control logic
assign heater = (mode == 1) && (too_cold || fan_on);

// Air conditioner control logic
assign aircon = (mode == 0) && (too_hot || fan_on);

// Fan control logic
assign fan = (heater || aircon || fan_on);

endmodule
