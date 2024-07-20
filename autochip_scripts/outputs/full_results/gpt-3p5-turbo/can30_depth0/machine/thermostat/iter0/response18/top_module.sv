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
    wire fan_ctrl;
    
    // Turn on fan if either too_cold or too_hot is high, or if fan_on is high
    assign fan_ctrl = (too_cold || too_hot || fan_on);
    
    // Turn on heater or air conditioner based on mode and room temperature
    assign heater = (mode && too_cold);
    assign aircon = (!mode && too_hot);
    
    // Assign fan control signal to fan output
    assign fan = fan_ctrl;

endmodule
