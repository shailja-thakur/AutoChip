module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Define internal signals
reg fan_internal;

// Output assignments
assign heater = (mode && too_cold) ? 1'b1 : 1'b0;
assign aircon = (~mode && too_hot) ? 1'b1 : 1'b0;
assign fan = (fan_on || heater || aircon) ? 1'b1 : 1'b0;

// Internal signal assignments
always @(fan_on, heater, aircon) begin
    if (fan_on || heater || aircon)
        fan_internal <= 1'b1;
    else
        fan_internal <= 1'b0;
end

// Connect internal signal to fan output
assign fan = fan_internal;

endmodule
