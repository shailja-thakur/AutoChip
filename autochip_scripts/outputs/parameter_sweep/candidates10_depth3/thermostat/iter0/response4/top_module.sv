module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
	// Declare internal signal
	wire fan_requested;
	
	// Assign fan_requested signal based on mode, too_hot, and fan_on inputs
	assign fan_requested = (mode == 1 & too_cold) | (mode == 0 & too_hot) | fan_on;
	
	// Turn on heater when too_cold is true and mode is heating
	assign heater = too_cold & mode;
	
	// Turn on aircon when too_hot is true and mode is cooling
	assign aircon = too_hot & ~mode;
	
	// Turn on fan when any of the following conditions are true:
	// 1. Heater is on
	// 2. Aircon is on
	// 3. Fan is requested by the user
	assign fan = heater | aircon | fan_requested;
endmodule
