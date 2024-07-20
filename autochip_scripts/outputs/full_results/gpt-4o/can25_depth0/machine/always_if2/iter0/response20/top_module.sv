module top_module (
	input cpu_overheated,
	input arrived,
	input gas_tank_empty,
	input shut_off_computer,
	output reg shut_off_computer_out,
	output reg keep_driving
);

	// Always block to control the shut_off_computer output
	always @(*) begin
		shut_off_computer_out = cpu_overheated ? 1'b1 : 1'b0;
	end

	// Always block to control the keep_driving output
	always @(*) begin
		if (arrived == 1'b0) 
			keep_driving = ~gas_tank_empty;
		else 
			keep_driving = 1'b0;
	end

endmodule
