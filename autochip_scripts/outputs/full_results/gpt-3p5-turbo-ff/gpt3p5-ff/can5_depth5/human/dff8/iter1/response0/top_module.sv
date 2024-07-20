module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	reg [7:0] q_reg;

	always @(posedge clk) begin
		q_reg <= d;
	end

	// Assign the value of q_reg to q outside the always block
	assign q = q_reg;

endmodule
