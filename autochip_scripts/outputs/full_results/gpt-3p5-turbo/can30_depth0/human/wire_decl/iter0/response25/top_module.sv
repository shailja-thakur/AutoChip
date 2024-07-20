module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );
	
	wire intermediate1;
	wire intermediate2;
	
	and gate1 (a, b, intermediate1);
	and gate2 (c, d, intermediate2);
	or gate3 (intermediate1, intermediate2, out);
	not gate4 (out, out_n);
	
endmodule
module and (
	input a,
	input b,
	output y );
	
	assign y = a & b;
	
endmodule
module or (
	input a,
	input b,
	output y );
	
	assign y = a | b;
	
endmodule
module not (
	input a,
	output y );
	
	assign y = ~a;

endmodule
