module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	/*
	* Equation derived from the Karnaugh map:
	* out = a'c'd + a'bc' + abd + ab'c'
	*/

	assign out = (~a & ~c & ~d) | (~a & b & ~c) | (a & b & d) | (a & ~b & ~c);
	
endmodule
