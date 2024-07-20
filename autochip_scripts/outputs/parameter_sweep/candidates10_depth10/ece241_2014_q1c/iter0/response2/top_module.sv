module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire declaration for intermediate signals
	wire [7:0] sum;
	wire carry;

	// Four-bit adder with carry
	// Container for each full adder instance's carry-out output
	wire [7:0] carry_out;
	
	// 8-bit adder
	adder8 A1 (
		.A(a),
		.B(b),
		.O(sum),
		.CO(carry_out[0])
	);
	
	// Output wire assignment
	assign s = sum;
	
	// Overflow detection
	assign overflow = (carry_out[7] == 1);
	
endmodule
module adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
	assign {cout,sum} = a + b + cin;
endmodule
module adder8 (
	input [7:0] A,
	input [7:0] B,
	output [7:0] O,
	output CO
);
	
	wire [6:0] carry_in = 0;
	wire [6:0] carry_out;
	
	assign O[0] = A[0] ^ B[0] ^ carry_in[0];
	assign carry_out[0] = (A[0] & B[0]) | (A[0] & carry_in[0]) | (B[0] & carry_in[0]);

	assign O[1] = A[1] ^ B[1] ^ carry_in[1];
	assign carry_out[1] = (A[1] & B[1]) | (A[1] & carry_in[1]) | (B[1] & carry_in[1]);

	assign O[2] = A[2] ^ B[2] ^ carry_in[2];
	assign carry_out[2] = (A[2] & B[2]) | (A[2] & carry_in[2]) | (B[2] & carry_in[2]);

	assign O[3] = A[3] ^ B[3] ^ carry_in[3];
	assign carry_out[3] = (A[3] & B[3]) | (A[3] & carry_in[3]) | (B[3] & carry_in[3]);

	assign O[4] = A[4] ^ B[4] ^ carry_in[4];
	assign carry_out[4] = (A[4] & B[4]) | (A[4] & carry_in[4]) | (B[4] & carry_in[4]);

	assign O[5] = A[5] ^ B[5] ^ carry_in[5];
	assign carry_out[5] = (A[5] & B[5]) | (A[5] & carry_in[5]) | (B[5] & carry_in[5]);

	assign O[6] = A[6] ^ B[6] ^ carry_in[6];
	assign carry_out[6] = (A[6] & B[6]) | (A[6] & carry_in[6]) | (B[6] & carry_in[6]);

	assign O[7] = A[7] ^ B[7] ^ carry_in[7];
	assign CO = (A[7] & B[7]) | (A[7] & carry_in[7]) | (B[7] & carry_in[7]);

	assign carry_in = carry_out;
	
endmodule
