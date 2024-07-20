module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );
	
	wire and1_out;
	wire and2_out;

	and gate_and1(and1_out, a, b);
	and gate_and2(and2_out, c, d);
	or gate_or(out, and1_out, and2_out);
	not gate_not(out_n, out);
	
endmodule
module and (
	output and_out,
	input a,
	input b );
	
	assign and_out = a & b;
	
endmodule
module or (
	output or_out,
	input a,
	input b );
	
	assign or_out = a | b;
	
endmodule
module not (
	output not_out,
	input a );
	
	assign not_out = ~a;
	
endmodule
