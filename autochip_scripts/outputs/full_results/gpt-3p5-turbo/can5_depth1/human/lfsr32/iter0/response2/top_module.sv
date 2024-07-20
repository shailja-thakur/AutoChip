module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] shift_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 32'h1;
		end else begin
			shift_reg <= {shift_reg[30:0], ((shift_reg[31] ^ shift_reg[21] ^ shift_reg[1] ^ shift_reg[0]))};
		end
	end

	assign q = shift_reg;

endmodule
