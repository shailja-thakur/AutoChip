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

	always @(posedge clk)
	begin
		if (fan == 1'b1)
			$display("Fan is turned on");
		else
			$display("Fan is turned off");
	end

	// Heater control
	always @(*)
	begin
		heater = mode && too_cold;
	end

	always @(posedge clk)
	begin
		if (heater == 1'b1)
			$display("Heater is turned on");
		else
			$display("Heater is turned off");
	end

	// Aircon control
	always @(*)
	begin
		aircon = mode && too_hot;
	end

	always @(posedge clk)
	begin
		if (aircon == 1'b1)
			$display("Aircon is turned on");
		else
			$display("Aircon is turned off");
	end

endmodule
