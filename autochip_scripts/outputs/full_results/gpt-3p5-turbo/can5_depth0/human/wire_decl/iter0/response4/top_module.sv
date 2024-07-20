module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate_wire1;
	wire intermediate_wire2;

	and gate1 ( intermediate_wire1, a, b );
	and gate2 ( intermediate_wire2, c, d );
	or gate3 ( out, intermediate_wire1, intermediate_wire2 );
	not gate4 ( out_n, out );
	
endmodule
