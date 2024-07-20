module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
	reg fan_state;
	assign fan = fan_on | fan_state;
	
	always @(mode or too_cold or too_hot) begin
		if(mode == 1 && too_cold)
			heater = 1;
		else if(mode == 0 && too_hot)
			aircon = 1;
		else {
			heater = 0;
			aircon = 0;
		}
		
		if(heater | aircon)
			fan_state = 1;
		else
			fan_state = 0;
	end
endmodule
