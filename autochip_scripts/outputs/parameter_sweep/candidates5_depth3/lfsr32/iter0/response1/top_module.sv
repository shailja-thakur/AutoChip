module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] shift_reg, feedback;
	assign q = shift_reg[0];

	always @(posedge clk or posedge reset) begin
		if (reset)
			shift_reg <= 32'b1;
		else begin
			feedback <= shift_reg[31] ^ shift_reg[21] ^ shift_reg[1] ^ shift_reg[0];
			shift_reg <= {feedback, shift_reg[31:1]};
		end
	end
endmodule
