module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	/* wire signals */
	wire [3:0] count_q;
	wire [3:1] count_ena;

	/* BCD counter */
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else if (count_ena[3])
			q <= q + 1;

		count_q <= q[3:0];
		count_ena <= ena;
	end

	/* Assign the output signals */
	assign ena = count_ena;
	assign q = {count_q, q[7:4]};

endmodule
