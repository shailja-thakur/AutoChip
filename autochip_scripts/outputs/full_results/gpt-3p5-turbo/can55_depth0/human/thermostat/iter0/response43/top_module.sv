module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

assign heater = (mode && too_cold) ? 1'b1 : 1'b0;
assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;
assign fan = (fan_on || heater || aircon) ? 1'b1 : 1'b0;

endmodule
