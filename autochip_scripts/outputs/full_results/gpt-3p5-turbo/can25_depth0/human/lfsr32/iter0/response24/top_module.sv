module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Registers
	reg [31:0] shift_reg;

	// Combinational Logic
	always @(*)
	begin
		// Next state calculation
		if (shift_reg[31] ^ shift_reg[21] ^ shift_reg[1] ^ shift_reg[0])
			shift_reg <= {shift_reg[30:0], 1'b1};
		else
			shift_reg <= shift_reg << 1;
	end

	// Synchronous reset
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			shift_reg <= 32'h1;
		else
			shift_reg <= shift_reg;
	end

	// Output assignment
	assign q = shift_reg;

endmodule
