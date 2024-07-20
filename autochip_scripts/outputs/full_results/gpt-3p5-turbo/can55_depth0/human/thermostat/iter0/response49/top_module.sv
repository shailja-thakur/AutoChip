module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
	//Declare internal signals
	wire should_heat, should_cool, should_fan;
	
	//Determine if heater should be turned on
	assign should_heat = (mode == 1) && too_cold;
	
	//Determine if air conditioner should be turned on
	assign should_cool = (mode == 0) && too_hot;
	
	//Determine if fan should be turned on
	assign should_fan = fan_on || should_heat || should_cool;
	
	//Turn on outputs based on conditions
	assign heater = should_heat;
	assign aircon = should_cool;
	assign fan = should_fan;
	
endmodule
