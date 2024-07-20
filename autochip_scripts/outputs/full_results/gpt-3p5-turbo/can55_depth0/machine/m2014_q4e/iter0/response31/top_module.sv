module top_module (
	input in1,
	input in2,
	output logic out
);
	
	// Declare internal signal to perform the logic operations
	logic internal_signal;
	
	// Logic implementation
	assign internal_signal = in1 | in2;
	assign out = ~internal_signal;
	
endmodule
