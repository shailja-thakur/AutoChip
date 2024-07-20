module top_module (
	input cpu_overheated,
	input arrived,
	input gas_tank_empty,
	input shut_off_computer, // Changed from output to input
	output reg keep_driving,
	output reg shut_off_computer_signal // Renamed to avoid name conflict with input
);

always @(*) begin
	if (cpu_overheated)
		shut_off_computer_signal = 1;
	else
		shut_off_computer_signal = 0;
end

always @(*) begin
	if (!arrived)
		keep_driving = ~gas_tank_empty;
	else
		keep_driving = 0;
end

endmodule
