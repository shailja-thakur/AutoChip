module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	always @(posedge clk) begin
		if (load) // check if load input is high
			q <= data; // load data input into output register

		else if (ena == 2'h1) // check if enable input is set to 2'h1
			q <= {q[98:0], 1'b0}; // shift output register to the left

		else if (ena == 2'h2) // check if enable input is set to 2'h2
			q <= {1'b0, q[99:1]}; // shift output register to the right
	end

endmodule
