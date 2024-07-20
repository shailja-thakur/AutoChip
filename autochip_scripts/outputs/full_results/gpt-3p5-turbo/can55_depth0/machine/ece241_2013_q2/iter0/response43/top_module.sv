module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

wire sop1, sop2, sop3, sop4, sop5, sop6;
wire pos0, pos1;

// out_sop output generation
andGate u1 (.a(c), .b(d), .z(sop1));
notGate u2 (.a(a), .z(sop2));
notGate u3 (.a(b), .z(sop3));
andGate u4 (.a(sop2), .b(sop3), .z(sop4));
andGate u5 (.a(sop4), .b(c), .z(sop5));
orGate u6 (.a(sop1), .b(sop5), .z(out_sop));

// out_pos output generation
notGate u7 (.a(b), .z(sop2));
orGate u8 (.a(sop2), .b(d), .z(sop3));
notGate u9 (.a(a), .z(sop4));
orGate u10 (.a(sop4), .b(b), .z(sop5));
andGate u11 (.a(sop5), .b(c), .z(pos0));
orGate u12 (.a(sop4), .b(d), .z(sop5));
andGate u13 (.a(sop5), .b(c), .z(pos1));
eq u14 (.a(pos0), .b(pos1), .z(out_pos));
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
