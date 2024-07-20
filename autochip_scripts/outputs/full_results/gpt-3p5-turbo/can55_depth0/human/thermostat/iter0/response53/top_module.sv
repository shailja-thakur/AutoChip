module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	reg fan_on_int;

	always @(fan_on) begin
		if (fan_on)
			fan_on_int <= 1'b1;
	end

	assign heater = (mode && too_cold && !too_hot && !fan_on_int);
	assign aircon = (!mode && !too_cold && too_hot && !fan_on_int);
	assign fan = (heater || aircon || fan_on_int);

endmodule
