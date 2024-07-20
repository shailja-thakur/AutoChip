module top_module(
	input [1:0] A,
	input [1:0] B,
	output logic z);

	// logic for the circuit
	assign z = (A == B) ? 1 : 0;

endmodule
