module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Implementation of the circuit
assign heater = (mode == 1 && too_cold == 1) ? 1'b1 : 1'b0;
assign aircon = (mode == 0 && too_hot == 1) ? 1'b1 : 1'b0;
assign fan = (fan_on == 1 || heater == 1 || aircon == 1) ? 1'b1 : 1'b0;

endmodule
