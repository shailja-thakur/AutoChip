module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Internal signals
	reg [3:0] q_ones;
	reg [7:4] q_tens;
	reg [11:8] q_hundreds;
	reg [15:12] q_thousands;
	reg [3:1] ena_temp;

	always @(posedge clk, posedge reset) begin
		if (reset)
			q <= 0;
		else begin
			if (ena_temp[1])
				q_ones <= q_ones + 1;
			if (ena_temp[2])
				q_tens <= q_tens + 1;
			if (ena_temp[3])
				q_hundreds <= q_hundreds + 1;
			q_thousands <= q_thousands + 1;
			q <= {q_thousands, q_hundreds, q_tens, q_ones};
		end
	end

	always @(*) begin
		ena_temp[1] = (q_ones == 9'b1001);
		ena_temp[2] = (q_tens == 9'b1001);
		ena_temp[3] = (q_hundreds == 9'b1001);
		ena = ena_temp;
	end

endmodule
