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
    fan_requested = (fan_on == 1'b1) ? 1'b1 : 1'b0;
    turn_on_heater = (mode == 1 && too_cold == 1'b1) ? 1'b1 : 1'b0;
    turn_on_aircon = (mode == 0 && too_hot == 1'b1) ? 1'b1 : 1'b0;
end

// Outputs
assign heater = (turn_on_heater == 1'b1 || (fan_requested == 1'b1 && (mode == 1 || mode == 0))) ? 1'b1 : 1'b0;
assign aircon = (turn_on_aircon == 1'b1 || (fan_requested == 1'b1 && (mode == 1 || mode == 0))) ? 1'b1 : 1'b0;
assign fan = (fan_requested == 1'b1 || heater == 1'b1 || aircon == 1'b1) ? 1'b1 : 1'b0;

endmodule
