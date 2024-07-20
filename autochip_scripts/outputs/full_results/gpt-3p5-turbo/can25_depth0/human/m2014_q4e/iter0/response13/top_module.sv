module top_module (
	input in1,
	input in2,
	output logic out
);
	
	// Declare internal wires
	wire temp;
	
	// Implement the NOR gate using a not and an or operator
	assign temp = ~(in1 | in2);
	assign out = temp;
	
endmodule
