module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Variables to store the state of the heating/cooling system
reg heater_state;
reg aircon_state;
reg fan_state;

// Combinational logic to determine the state of the heater, aircon, and fan
always @* begin
	heater_state = (mode == 1) && too_cold;
	aircon_state = (mode == 0) && too_hot;
	fan_state = heater_state || aircon_state || fan_on;
end

// Assign the output signals based on the state
assign heater = heater_state;
assign aircon = aircon_state;
assign fan = fan_state;

endmodule
