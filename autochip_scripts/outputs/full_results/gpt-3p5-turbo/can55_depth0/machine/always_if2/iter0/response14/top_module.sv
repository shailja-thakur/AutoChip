module top_module (
	input cpu_overheated,
	output reg shut_off_computer,
	input arrived,
	input gas_tank_empty,
	output reg keep_driving
);
	
	always @(*) begin
		if (cpu_overheated == 1)
			shut_off_computer = 1;
		else
			shut_off_computer = 0;
	end
	
	always @(*) begin
		if (arrived == 0)
			keep_driving = ~gas_tank_empty;
		else
			keep_driving = 0;
	end
	
endmodule
