module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;

	and_gate and1 (.a(a), .b(b), .z(intermediate1));
	and_gate and2 (.a(c), .b(d), .z(intermediate2));
	or_gate or1 (.a(intermediate1), .b(intermediate2), .z(out));

	not_gate not1 (.a(out), .z(out_n));

	
endmodule
