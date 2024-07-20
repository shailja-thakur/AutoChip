module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	// Internal wires and reg
	reg [15:0] q_next;
	reg [3:0] q_ones, q_tens, q_hundreds, q_thousands;
	reg enable_ones, enable_tens, enable_hundreds;

	// Sequential always block
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
			q_next <= 0;
			q_ones <= 0;
			q_tens <= 0;
			q_hundreds <= 0;
			enable_ones <= 1;
			enable_tens <= 0;
			enable_hundreds <= 0;
		end
		else begin
			q <= q_next;
			q_ones <= q_next[3:0];
			q_tens <= q_next[7:4];
			q_hundreds <= q_next[11:8];

			enable_ones <= (q_next[3:0] == 9);
			enable_tens <= (q_next[7:4] == 9);
			enable_hundreds <= (q_next[11:8] == 9);

			if (enable_ones)       q_next[3:0] <= q_next[3:0] + 1;
			else if (enable_tens)  q_next[7:4] <= q_next[7:4] + 1;
			else if (enable_hundreds) q_next[11:8] <= q_next[11:8] + 1;
		end
	end

	// Assign statements for outputs
	assign ena = {enable_hundreds, enable_tens, enable_ones};
	assign q = {q_ones, q_tens, q_hundreds, q_thousands};

endmodule
