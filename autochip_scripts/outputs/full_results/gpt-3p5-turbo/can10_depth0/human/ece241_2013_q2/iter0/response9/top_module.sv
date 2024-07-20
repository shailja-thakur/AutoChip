module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

	// Define intermediate signals for convenience
	wire [3:0] inputs = {a, b, c, d};

	// Determine the output out_sop in minimum sum-of-products form
	assign out_sop = (inputs == 2'b10) | (inputs == 2'b111) | (inputs == 2'b1111);

	// Determine the output out_pos in minimum product-of-sums form
	assign out_pos = (inputs != 2'b00) & (inputs != 2'b01) & (inputs != 2'b0100) & (inputs != 2'b0101) & (inputs != 2'b0110) & (inputs != 2'b1001) & (inputs != 2'b1010) & (inputs != 2'b1101) & (inputs != 2'b1110);

endmodule
