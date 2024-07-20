module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define intermediate wires for the circuit
wire c_and_d;       // Logical AND of inputs c and d
wire not_a;         // Logical NOT of input a
wire not_b;         // Logical NOT of input b
wire not_c;         // Logical NOT of input c
wire not_d;         // Logical NOT of input d
wire sop_expr;      // Intermediate wire for the SOP expression
wire pos0, pos1;    // Intermediate wires for the POS expression

// Generate the SOP expression
assign c_and_d = c & d;
assign not_a = ~a;
assign not_b = ~b;
assign not_c = ~c;
assign not_d = ~d;
assign sop_expr = (not_a & not_b & c) | c_and_d;

// Generate the POS expression
assign pos0 = c & (not_b | d) & (not_a | b);
assign pos1 = c & (not_a | d);
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

// Output signals
assign out_sop = sop_expr;

endmodule
