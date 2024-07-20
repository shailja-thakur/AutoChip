module top_module (
	input cpu_overheated,
	input arrived,
	input gas_tank_empty,
	input shut_off_computer,
	output reg keep_driving,
	output reg shut_off_computer_out
);

	// Control the "shut_off_computer_out" output
	always @(*) begin
		if (cpu_overheated) begin
			shut_off_computer_out = 1;
		end else begin
			shut_off_computer_out = 0;
		end
	end

	// Control the "keep_driving" output
	always @(*) begin
		if (!arrived) begin
			keep_driving = ~gas_tank_empty;
		end else begin
			keep_driving = 0;
		end
	end

endmodule
