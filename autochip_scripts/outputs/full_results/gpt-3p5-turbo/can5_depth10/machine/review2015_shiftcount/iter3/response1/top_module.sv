module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q
);

	reg [3:0] q_reg;

	always @(posedge clk) begin
		if (count_ena) begin
			q_reg <= q_reg - 1;
		end else if (shift_ena) begin
			q_reg <= data;
		end
	end

	assign q = q_reg;

endmodule
