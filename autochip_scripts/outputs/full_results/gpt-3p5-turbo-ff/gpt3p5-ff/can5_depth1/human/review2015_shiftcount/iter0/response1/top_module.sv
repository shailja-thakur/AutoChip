module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	reg [3:0] shift_reg;

	always @(posedge clk) begin
		if (count_ena && !shift_ena) begin
			if (shift_reg == 4'b0000)
				shift_reg <= 4'b1111;
			else
				shift_reg <= shift_reg - 1;
		end

		if (shift_ena && !count_ena) begin
			shift_reg[3] <= data;
			shift_reg[2] <= shift_reg[3];
			shift_reg[1] <= shift_reg[2];
			shift_reg[0] <= shift_reg[1];
		end
	end

	assign q = shift_reg;

endmodule
