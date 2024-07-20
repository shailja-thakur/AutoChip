module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

	/* Define internal signals */

	wire n1_out, n2_out;

	/* Instantiate NAND gates */

	nand_gate NAND1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(n1_out));
	nand_gate NAND2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(n2_out));

	/* Assign outputs */

	assign p1y = n1_out;
	assign p2y = n2_out;

endmodule
module nand_gate(
	input a,
	input b,
	input c,
	input d,
	output y
);

	/* Instantiate AND gate and NOT gate */

	and_gate AND1(.a(a), .b(b), .c(c), .d(d), .e(ya));
	not_gate NOT1(.a(ya), .y(y));

endmodule
module and_gate(
	input a,
	input b,
	input c,
	input d,
	output e
);

	wire ab, cd;
	wire abcd;

	and(A1, a, b);
	and(A2, c, d);
	and(A3, ab, cd);
	and(A4, abcd, abcd);

endmodule
module not_gate(
	input a,
	output y
);

	not(N1, a, y);

endmodule
