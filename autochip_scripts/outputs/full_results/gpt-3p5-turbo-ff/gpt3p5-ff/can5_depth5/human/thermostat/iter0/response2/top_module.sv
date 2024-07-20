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
	reg fan_on_internal;
	
	// Assign internal signals
	assign heater = (mode && too_cold) ? 1'b1 : 1'b0;
	assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;
	assign fan = (heater || aircon || fan_on || fan_on_internal) ? 1'b1 : 1'b0;
	
	// Process for internal signal fan_on_internal
	always @(posedge fan_on or posedge mode or posedge too_cold or posedge too_hot) begin
		if (fan_on || fan_on_internal) begin
			fan_on_internal <= 1'b1;
		end else if (fan_on_internal && !mode && !too_hot) begin
			fan_on_internal <= 1'b0;
		end else if (fan_on_internal && mode && !too_cold) begin
			fan_on_internal <= 1'b0;
		end
	end
	
endmodule
