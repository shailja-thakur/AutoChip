module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

// Declare internal signals
reg fan_on_internal;
wire heater_fan_on;
wire aircon_fan_on;

// Assign internal signals
assign fan_on_internal = fan_on || heater || aircon;
assign heater_fan_on = (mode == 1) && too_cold;
assign aircon_fan_on = (mode == 0) && too_hot;

// Control outputs based on internal signals
assign heater = heater_fan_on ? 1'b1 : 1'b0;
assign aircon = aircon_fan_on ? 1'b1 : 1'b0;
assign fan = fan_on_internal ? 1'b1 : 1'b0;

endmodule
