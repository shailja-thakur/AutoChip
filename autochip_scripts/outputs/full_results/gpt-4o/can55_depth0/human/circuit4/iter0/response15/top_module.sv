module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
    // The observed pattern suggests q is 1 if either (c == 1) or (b == 1) and (a == 0)
    assign q = c | (b & ~a);
endmodule
