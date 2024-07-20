module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	//wire to connect different parts of the module
	wire fan_ctrl;
	
	//turn on the fan if too_cold or too_hot is high, or if fan_on is high
	assign fan_ctrl = (too_cold || too_hot || fan_on);
	
	//turn on the heater if mode is high and too_cold is high
	assign heater = (mode && too_cold);
	
	//turn on the aircon if mode is low and too_hot is high
	assign aircon = (!mode && too_hot);
	
	//connect fan_ctrl wire to the fan output
	assign fan = fan_ctrl;
	
endmodule
