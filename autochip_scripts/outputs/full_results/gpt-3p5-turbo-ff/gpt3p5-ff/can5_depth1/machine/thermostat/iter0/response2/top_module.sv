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
	reg heater;
	reg aircon;

	always @(*) begin
		if (fan_on || too_cold || too_hot) begin
			fan = 1;
		end else begin
			fan = 0;
		end

		if (mode && too_cold) begin
			heater = 1;
		end else begin
			heater = 0;
		end

		if (!mode && too_hot) begin
			aircon = 1;
		end else begin
			aircon = 0;
		end
	end

	assign fan = fan;
	assign heater = heater;
	assign aircon = aircon;
endmodule
