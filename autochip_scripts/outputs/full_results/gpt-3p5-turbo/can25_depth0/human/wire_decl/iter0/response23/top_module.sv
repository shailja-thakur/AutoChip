module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;
	
	andGate and1(a, b, intermediate1);
	andGate and2(c, d, intermediate2);
	orGate or1(intermediate1, intermediate2, out);
	notGate not1(out, out_n);
	
endmodule
