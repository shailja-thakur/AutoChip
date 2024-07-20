module top_module (
	input cpu_overheated,
	output reg shut_off_computer,
	input arrived,
	input gas_tank_empty,
	output reg keep_driving
);

always @* begin
	if (cpu_overheated == 1'b1)
		shut_off_computer = 1'b1;
	else
		shut_off_computer = 1'b0;
end

always @* begin
	if (arrived == 1'b0)
		keep_driving = ~gas_tank_empty;
	else
		keep_driving = 1'b0;
end

endmodule
