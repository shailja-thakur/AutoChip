module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] shift_reg;

	// Reset logic
	always @(posedge clk) begin
		if (reset)
			shift_reg <= 32'h1;
		else
			shift_reg <= {shift_reg[30:0], shift_reg[31] ^ shift_reg[21] ^ shift_reg[1] ^ shift_reg[0]};
	end

	// Assigning output
	assign q = shift_reg;

endmodule
