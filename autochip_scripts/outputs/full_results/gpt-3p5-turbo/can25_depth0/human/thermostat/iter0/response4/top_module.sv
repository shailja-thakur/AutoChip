module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
    // Internal signal declarations
    wire fan_control;
    
    // Heater control
    assign heater = (mode == 1) && (too_cold == 1) && (fan_on == 1);
    
    // Air conditioner control
    assign aircon = (mode == 0) && (too_hot == 1) && (fan_on == 1);
    
    // Fan control
    assign fan_control = (heater == 1) || (aircon == 1) || (fan_on == 1);
    assign fan = fan_control;
    
endmodule
