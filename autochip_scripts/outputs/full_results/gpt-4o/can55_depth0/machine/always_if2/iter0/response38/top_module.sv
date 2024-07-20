module top_module (
	input cpu_overheated,
	output reg shut_off_computer,
	input arrived,
	input gas_tank_empty,
	output reg keep_driving,
	input shut_off_computer_in   // Added this extra input for shut_off_computer
);

always @(*) begin
	if (cpu_overheated)
		shut_off_computer = 1;
	else
		shut_off_computer = shut_off_computer_in;  // To ensure this output can be controlled externally as described
end

always @(*) begin
	if (arrived)
		keep_driving = 0;
	else
		keep_driving = !gas_tank_empty;
end

endmodule
