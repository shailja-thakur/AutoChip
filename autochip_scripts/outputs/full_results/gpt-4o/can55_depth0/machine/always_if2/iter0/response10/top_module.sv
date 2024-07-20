module top_module (
	input cpu_overheated,
	input shut_off_computer_signal,   // renamed to avoid output and input signal name conflict
	input arrived,
	input gas_tank_empty,
	output reg shut_off_computer,
	output reg keep_driving
);

	always @(*) begin
		if (cpu_overheated)
			shut_off_computer = 1;
		else
			shut_off_computer = 0;
	end

	always @(*) begin
		if (!arrived)
			keep_driving = ~gas_tank_empty;
		else
			keep_driving = 0;
	end
	
endmodule
