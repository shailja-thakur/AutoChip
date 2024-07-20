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
	wire fan_output;
	wire heater_output;
	wire aircon_output;
	
	// Assign outputs
	assign fan = fan_output;
	assign heater = heater_output;
	assign aircon = aircon_output;
	
	// Logic for controlling the fan
	assign fan_output = (too_cold || too_hot || fan_on);
	
	// Logic for controlling the heater
	assign heater_output = (mode && too_cold);
	
	// Logic for controlling the air conditioner
	assign aircon_output = (!mode && too_hot);
	
endmodule
