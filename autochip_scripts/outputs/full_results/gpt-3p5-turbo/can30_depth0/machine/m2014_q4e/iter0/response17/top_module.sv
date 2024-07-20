module top_module (
	input in1,
	input in2,
	output logic out
);
	
	// use not, or, assign statement to define output
	assign out = ~(in1 | in2);
	
endmodule
