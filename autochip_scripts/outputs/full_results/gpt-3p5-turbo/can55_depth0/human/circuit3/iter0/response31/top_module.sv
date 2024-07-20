module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Assign statement for the output q
	assign q = ~((~(a & b)) | (c & d));
endmodule
