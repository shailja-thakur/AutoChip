module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] shift_reg;

	always @(posedge clk or posedge reset) begin
		if(reset)
			shift_reg <= 32'h1;
		else
			shift_reg <= {shift_reg[30:0] ^ shift_reg[20:0] ^ shift_reg[0], shift_reg[31]};
	end

	assign q = shift_reg;

endmodule
