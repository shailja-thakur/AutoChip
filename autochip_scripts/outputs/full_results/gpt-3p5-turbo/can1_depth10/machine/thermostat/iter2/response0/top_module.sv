module top_module(
    input mode,
    input too_cold, 
    input too_hot,
    input fan_on,
    output reg heater,
    output reg aircon,
    output reg fan
);


	// Fan control
	always @(*)
	begin
		fan = fan_on || too_cold || too_hot;
	end

	// Heater control
	always @(*)
	begin
		heater = mode && too_cold;
	end

	// Aircon control
	always @(*)
	begin
		aircon = !mode && too_hot;
	end

endmodule
