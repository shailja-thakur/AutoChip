module top_module(
	input wire x,
	input wire y,
	output wire z);

	// Gates
	wire gate1_output;
	wire gate2_output;
	wire gate3_output;
	
	and gate1(x, y, gate1_output); // First gate 
	and gate2(y, x, gate2_output); // Second gate
	and gate3(gate1_output, gate2_output, z); // Third gate

endmodule
