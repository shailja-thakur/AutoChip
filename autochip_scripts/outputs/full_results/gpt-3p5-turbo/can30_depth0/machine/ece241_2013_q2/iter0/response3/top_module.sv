module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Declare intermediate wires
	wire sop_wire1;
	wire sop_wire2;
	wire sop_wire3;
	wire pos_wire0;
	wire pos_wire1;

	// SOP expression
	assign sop_wire1 = c & d;
	assign sop_wire2 = ~a & ~b & c;
	assign out_sop = sop_wire1 | sop_wire2;

	// POS expression
	assign pos_wire0 = c & (~b | d) & (~a | b);
	assign pos_wire1 = c & (~a | d);
	assign out_pos = (pos_wire0 == pos_wire1) ? pos_wire0 : 1'bx;

endmodule
