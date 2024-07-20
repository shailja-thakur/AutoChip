module top_module (
	input in1,
	input in2,
	output logic out
);

	// Declare intermediate signals
	logic and_result;
	logic not_result;
	
	// Perform logical AND operation
	assign and_result = in1 & in2;
	
	// Perform logical NOT operation
	assign not_result = !in2;
	
	// Output the result
	assign out = and_result & not_result;

endmodule
