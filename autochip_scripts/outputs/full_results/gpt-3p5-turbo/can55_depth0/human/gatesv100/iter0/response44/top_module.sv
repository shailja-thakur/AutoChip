module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Declare internal wire to store the value of input bits
	wire [99:0] in_reg;

	// Register the input bits for the next cycle
	always @(posedge clk) begin
		in_reg <= in;
	end

	// Logic to compute out_both
	assign out_both[0] = in_reg[0] & in_reg[99];
	assign out_both[1:98] = in_reg[1:98] & in_reg[0:97];

	// Logic to compute out_any
	assign out_any[1:99] = in_reg[0:98] | in_reg[1:99];
	
	// Logic to compute out_different
	assign out_different[0:97] = (in_reg[0:97] != in_reg[1:98]);
	assign out_different[98] = (in_reg[98] != in_reg[99]);

endmodule
