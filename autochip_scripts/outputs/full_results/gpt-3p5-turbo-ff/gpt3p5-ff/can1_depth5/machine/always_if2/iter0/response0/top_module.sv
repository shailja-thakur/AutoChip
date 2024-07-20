module top_module (
	input cpu_overheated,
	output reg shut_off_computer,
	input arrived,
	input gas_tank_empty,
	output reg keep_driving
);

	always @(*) begin
		if (cpu_overheated == 1'b1) // If the computer is overheating
			shut_off_computer = 1'b1; // Shut off the computer
		else
			shut_off_computer = 1'b0; // Keep the computer running
	end

	always @(*) begin
		if (arrived == 1'b0) // If the car has not arrived at its destination
			keep_driving = ~gas_tank_empty; // Keep driving if the gas tank is not empty
		else
			keep_driving = 1'b0; // Stop driving
	end

endmodule
