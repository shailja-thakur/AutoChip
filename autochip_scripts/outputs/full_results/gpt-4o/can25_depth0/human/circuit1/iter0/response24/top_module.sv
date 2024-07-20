module top_module (
	input a, 
	input b, 
	output q
);
    // q is 1 only when both a and b are 1
    assign q = a & b;

endmodule
