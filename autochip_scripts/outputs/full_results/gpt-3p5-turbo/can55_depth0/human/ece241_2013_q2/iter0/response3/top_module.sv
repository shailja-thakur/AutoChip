module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	// Define intermediate signals
	wire[3:0] inputs;
	wire out;

	// Assign inputs
	assign inputs = {a, b, c, d};

	// Determine the output out_sop in minimum sum-of-products form
	assign out_sop = (inputs == 4'b0010) || (inputs == 4'b0111) || (inputs == 4'b1111);

	// Determine the output out_pos in minimum product-of-sums form
	assign out_pos = (inputs != 4'b0000) && (inputs != 4'b0001) && (inputs != 4'b0100) && (inputs != 4'b0101) && (inputs != 4'b0110) && (inputs != 4'b1001) && (inputs != 4'b1010) && (inputs != 4'b1101) && (inputs != 4'b1110);

endmodule
