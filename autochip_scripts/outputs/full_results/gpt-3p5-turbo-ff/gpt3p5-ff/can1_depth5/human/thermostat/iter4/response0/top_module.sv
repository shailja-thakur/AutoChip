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
reg fan_requested;
reg turn_on_heater;
reg turn_on_aircon;

// Assignments
always @* begin
    fan_requested = (fan_on || (mode == 1 && too_cold));
    turn_on_heater = (mode == 1 && too_cold);
    turn_on_aircon = (mode == 0 && too_hot);
end

// Outputs
assign heater = (turn_on_heater || fan_requested) ? 1'b1 : 1'b0;
assign aircon = (turn_on_aircon || fan_requested) ? 1'b1 : 1'b0;
assign fan = (heater || aircon || fan_requested) ? 1'b1 : 1'b0;

endmodule
