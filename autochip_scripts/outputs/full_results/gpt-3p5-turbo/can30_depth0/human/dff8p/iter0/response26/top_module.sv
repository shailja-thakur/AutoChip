module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_ff [7:0];

	always @(negedge clk or posedge reset) begin
		if (reset)
			q_ff <= 8'h34;
		else
			q_ff <= d;
	end

	assign q = q_ff;

endmodule
