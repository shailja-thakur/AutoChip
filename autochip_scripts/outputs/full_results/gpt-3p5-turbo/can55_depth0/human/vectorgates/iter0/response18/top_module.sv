module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Wire declarations
	wire [2:0] a_not, b_not;
	wire [2:0] a_or_b;
	wire or_out;

	// Logic gates
	or_gate or1(.a(a), .b(b), .out(a_or_b));
	or_gate or2(.a(or_in), .b(or_in), .out(or_out));

	// Inverters
	not_gate not1(.a(a), .out(a_not));
	not_gate not2(.a(b), .out(b_not));

	// Assign outputs
	assign out_or_bitwise = a_or_b;
	assign out_or_logical = or_out;
	assign out_not = {b_not, a_not};

endmodule
module or_gate(
	input [2:0] a,
	input [2:0] b,
	output [2:0] out
);
	assign out = a | b;
endmodule
module not_gate(
	input [2:0] a,
	output [2:0] out
);
	assign out = ~a;
endmodule
