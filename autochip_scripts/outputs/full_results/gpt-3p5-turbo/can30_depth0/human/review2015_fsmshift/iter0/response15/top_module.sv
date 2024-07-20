module top_module(
	input clk,
	input reset,
	output shift_ena);

	// Instantiate the shift register module
	shift_register shift_reg(
		.clk(clk),
		.reset(reset),
		.shift_ena(shift_ena)
	);

	// Create a counter to count the clock cycles after reset
	reg [2:0] count;

	// Synchronous reset
	always @(posedge clk) begin
		// Check if reset is active
		if (reset) begin
			count <= 3'b111;
		end else begin
			// Decrement the counter
			count <= count - 1;
		end
	end

	// Output enable signal
	assign shift_ena = (count > 0);

endmodule
module shift_register(
	input clk,
	input reset,
	output shift_ena);
	
	reg [3:0] data;

	always @(posedge clk or posedge reset) begin
		// Synchronous reset
		if (reset) begin
			data <= 4'b0000;
		end else begin
			// Shift the data on every clock cycle
			data <= {data[2:0], data[3]};
		end
	end

	// Output the shift enable signal
	assign shift_ena = (data == 4'b0101) ? 1'b1 : 1'b0;

endmodule
