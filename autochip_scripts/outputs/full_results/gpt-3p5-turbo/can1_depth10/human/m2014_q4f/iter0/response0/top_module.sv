module top_module (
	input in1,
	input in2,
	output logic out
);
	
	assign out = in1 & ~in2; // Implementing the AND gate with a bubble on in2 input
	
endmodule
