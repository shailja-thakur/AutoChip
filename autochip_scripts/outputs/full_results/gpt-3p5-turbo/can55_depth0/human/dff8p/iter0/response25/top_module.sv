module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_ff [7:0];

	always @(negedge clk) begin
		if (reset)
			q <= 8'b00110100;
		else
			q <= q_ff;
		end

	// D Flip-Flops
	genvar i;
	generate
		for (i=0; i<8; i=i+1) begin: dff_gen
			always @(negedge clk) begin
				if (reset)
					q_ff[i] <= 8'b00110100;
				else
					q_ff[i] <= d[i];
			end
		end
	endgenerate

endmodule
