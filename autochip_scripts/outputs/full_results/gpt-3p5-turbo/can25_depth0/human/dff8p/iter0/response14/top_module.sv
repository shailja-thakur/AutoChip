module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_reg; // register to store the previous q values

	always @(negedge clk) begin
		if (reset)
			q_reg <= 8'h34; // reset q_reg to 0x34
		else
			q_reg <= d; // update q_reg with d value
	end

	assign q = q_reg; // assign q_reg to q output
endmodule
