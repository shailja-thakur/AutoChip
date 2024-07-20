module top_module (
	input cpu_overheated,
	input arrived,
	input gas_tank_empty,
	input shut_off_computer_signal,
	output reg shut_off_computer,
	output reg keep_driving
);

	// Control the shut_off_computer output
	always @(*) begin
		if (cpu_overheated)
			shut_off_computer <= 1;
		else
			shut_off_computer <= 0;
	end

	// Control the keep_driving output
	always @(*) begin
		if (arrived)
			keep_driving <= 0;
		else
			keep_driving <= ~gas_tank_empty;
	end

endmodule
