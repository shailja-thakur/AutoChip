module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	/* 8 D flip-flops */
	reg [7:0] q_tmp;

	always @(posedge clk) begin
		if (reset)
			q_tmp <= 8'b0;
		else
			q_tmp <= d;
	end

	assign q = q_tmp;

endmodule
