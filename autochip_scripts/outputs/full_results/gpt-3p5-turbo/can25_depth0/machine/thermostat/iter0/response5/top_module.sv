module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	reg fan;

	always @(*)
	begin
		if (fan_on == 1'b1 || too_cold == 1'b1 || too_hot == 1'b1)
			fan = 1'b1;
		else
			fan = 1'b0;
	end
	
	assign fan = (fan_on == 1'b1 || too_cold == 1'b1 || too_hot == 1'b1) ? 1'b1 : 1'b0;
	
	assign heater = (mode == 1'b1 && too_cold == 1'b1) ? 1'b1 : 1'b0;
	
	assign aircon = (mode == 1'b0 && too_hot == 1'b1) ? 1'b1 : 1'b0;

endmodule
