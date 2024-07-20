module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Implement fan control logic
assign fan = (fan_on || too_cold || too_hot);

// Implement heater control logic
assign heater = (mode && too_cold);

// Implement air conditioner control logic
assign aircon = (!mode && too_hot);

endmodule
