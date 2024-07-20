module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);

	reg [7:0] q_int;

	always @(posedge clk or posedge areset) begin
		if (areset)
			q_int <= 8'b0;
		else
			q_int <= d;
	end

	assign q = q_int;

endmodule
