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

// Check if the fan should be turned on
assign fan = fan_on | fan_on_internal;

always @(*) begin
	// Determine internal signals based on mode and input conditions
	if (mode == 1 && too_cold)
	begin
		heater = 1;
		aircon = 0;
		fan_on_internal = 1;
	end
	else if (mode == 0 && too_hot)
	begin
		heater = 0;
		aircon = 1;
		fan_on_internal = 1;
	end
	else
	begin
		heater = 0;
		aircon = 0;
		fan_on_internal = fan_on;
	end
end

endmodule
