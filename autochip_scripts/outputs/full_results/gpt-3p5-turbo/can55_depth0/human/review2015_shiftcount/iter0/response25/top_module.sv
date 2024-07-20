module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	// Internal signals
	reg [3:0] shift_reg;
	reg [3:0] next_shift_reg;
	reg [3:0] next_q;

	always @(posedge clk) begin
		if (shift_ena)
			next_shift_reg[3:1] = shift_reg[2:0];
			next_shift_reg[0]     = data;
		else if (count_ena)
			next_shift_reg = shift_reg - 1;
		else
			next_shift_reg = shift_reg;

		shift_reg <= next_shift_reg;
		next_q     <= next_shift_reg;
	end

	assign q = next_q;
endmodule
