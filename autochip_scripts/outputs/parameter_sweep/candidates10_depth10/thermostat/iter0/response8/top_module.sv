module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Internal wire to control the heater, aircon, and fan
wire heater_control;
wire aircon_control;
wire fan_control;

// Heater control logic
assign heater = (mode == 1) && too_cold && ~fan_on ? 1'b1 : 1'b0;

// Air conditioner control logic
assign aircon = (mode == 0) && too_hot && ~fan_on ? 1'b1 : 1'b0;

// Fan control logic
assign fan = fan_on || heater || aircon ? 1'b1 : 1'b0;

endmodule
