module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// This is a 4-input AND gate
assign q = a & b & c & d;

endmodule
