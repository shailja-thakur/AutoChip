module top_module (
	input in1,
	input in2,
	output logic out
);
	
	assign out = in1 & ~in2; // Implementing AND gate with bubble on in2 input
	
endmodule
