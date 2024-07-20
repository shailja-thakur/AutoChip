module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Define internal signals
	reg [15:0] next_q;

	// Synchronous logic for counter
	always @(posedge clk or posedge reset) begin
		if (reset)
			next_q <= 0;
		else begin
			next_q <= next_q;
			if (ena[1])
				next_q[7:4] <= next_q[7:4] + 1;
			if (ena[2])
				next_q[11:8] <= next_q[11:8] + 1;
			if (ena[3])
				next_q[15:12] <= next_q[15:12] + 1;
		end
	end

	// Assign outputs
	assign q = next_q;
	assign ena = {1'b0, ena[3:1]}; // Add a 0 to the MSB of ena

endmodule
