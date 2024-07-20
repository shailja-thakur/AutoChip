module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Internal signals
	wire [3:0] c;
	wire [3:0] s;

	// Full adders
	full_adder fa0(x[0], y[0], 1'b0, s[0], c[0]); // The first full adder adds the LSBs with no carry in
	full_adder fa1(x[1], y[1], c[0], s[1], c[1]); // The second full adder adds the next LSBs with the carry out from the previous adder
	full_adder fa2(x[2], y[2], c[1], s[2], c[2]); // The third full adder adds the next LSBs with the carry out from the previous adder
	full_adder fa3(x[3], y[3], c[2], s[3], c[3]); // The fourth full adder adds the MSBs with the carry out from the previous adder
	
	// Assign the sum outputs
	assign {c[3], s[3:0]} = sum;

endmodule
