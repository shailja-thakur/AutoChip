module top_module (
	input cpu_overheated,
	input arrived,
	input gas_tank_empty,
	output reg shut_off_computer,
	output reg keep_driving
);

	always @(cpu_overheated) begin
		if(cpu_overheated)
			shut_off_computer <= 1;
		else
			shut_off_computer <= 0;
	end

	always @(arrived, gas_tank_empty) begin
		if(arrived)
			keep_driving <= 0;
		else
			keep_driving <= ~gas_tank_empty;
	end

endmodule
