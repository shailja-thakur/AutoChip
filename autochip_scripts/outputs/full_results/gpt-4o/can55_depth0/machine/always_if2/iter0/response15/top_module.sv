module top_module (
	input cpu_overheated,
	input arrived,
	input gas_tank_empty,
	input shut_off_computer,  // Changed from output to input. There should not be two outputs with the same name.
	output reg shut_off_computer_out, // Renamed to avoid conflict with the input
	output reg keep_driving
);

	// Always block to control the shut_off_computer output
	always @(*) begin
		if (cpu_overheated) begin
			shut_off_computer_out = 1;
		end else begin
			shut_off_computer_out = 0;
		end
	end

	// Always block to control the keep_driving output
	always @(*) begin
		if (!arrived) begin
			keep_driving = !gas_tank_empty;
		end else begin
			keep_driving = 0;
		end
	end

endmodule
