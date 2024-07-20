module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Instantiating full adders
	wire [3:0] s;
	wire c_out;
	
	full_adder fa0 (.a(x[0]), .b(y[0]), .c_in(1'b0), .sum(s[0]), .c_out(c_out));
	full_adder fa1 (.a(x[1]), .b(y[1]), .c_in(c_out), .sum(s[1]), .c_out(c_out));
	full_adder fa2 (.a(x[2]), .b(y[2]), .c_in(c_out), .sum(s[2]), .c_out(c_out));
	full_adder fa3 (.a(x[3]), .b(y[3]), .c_in(c_out), .sum(s[3]), .c_out(c_out));

	assign sum = {c_out, s};
	
endmodule
module full_adder (
	input a,
	input b,
	input c_in,
	output sum,
	output c_out
);
	
	xor gates (
		.a(a),
		.b(b),
		.out(sum_1)
	);
	
	xor g1 (
		.a(sum_1),
		.b(c_in),
		.out(sum)
	);
	
	and g2 (
		.a(sum_1),
		.b(c_in),
		.out(and_1)
	);
	
	and g3 (
		.a(a),
		.b(b),
		.out(and_2)
	);
	
	or gate (
		.a(and_1),
		.b(and_2),
		.out(c_out)
	);
	
endmodule
