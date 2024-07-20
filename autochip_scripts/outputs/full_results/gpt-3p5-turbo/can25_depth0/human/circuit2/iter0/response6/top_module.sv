module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Implementing the combinational circuit
assign q = (a & !b & c) | (!a & b & !c & d) | (!a & b & c & !d) | (!a & !b & !c & d) | (!a & !b & c & !d);

endmodule
