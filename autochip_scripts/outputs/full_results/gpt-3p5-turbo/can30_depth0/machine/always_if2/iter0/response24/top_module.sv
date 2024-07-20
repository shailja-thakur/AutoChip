module top_module (
	input cpu_overheated,
	input arrived,
	input gas_tank_empty,
	output reg keep_driving,
	output reg shut_off_computer
);

	always @* begin
		if (cpu_overheated == 1) begin
			shut_off_computer = 1;
		end else begin
			shut_off_computer = 0;
		end
	end

	always @* begin
		if (arrived == 0) begin
			keep_driving = ~gas_tank_empty;
		end else begin
			keep_driving = 0;
		end
	end

endmodule
