module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

	// Output q is determined by the following boolean equation:
	// q = !((!a & !b & !c & !d) | (!a & !b & !c & d) | (!a & !b & c & !d) | (!a & !b & c & d) | (!a & b & !c & !d) | (!a & b & !c & d) | (!a & b & c & !d) | (!a & b & c & d) | (a & !b & !c & !d) | (a & !b & !c & d) | (a & !b & c & !d) | (a & !b & c & d) | (a & b & !c & !d) | (a & b & !c & d) | (a & b & c & !d) | (a & b & c & d))

	assign q = !((!a & !b & !c & !d) | (!a & !b & !c & d) | (!a & !b & c & !d) | (!a & !b & c & d) | 
	            (!a & b & !c & !d) | (!a & b & !c & d) | (!a & b & c & !d) | (!a & b & c & d) | 
	            (a & !b & !c & !d) | (a & !b & !c & d) | (a & !b & c & !d) | (a & !b & c & d) | 
	            (a & b & !c & !d) | (a & b & !c & d) | (a & b & c & !d) | (a & b & c & d));

endmodule
