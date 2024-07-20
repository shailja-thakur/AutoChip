module top_module (
	input a,
	input b,
	output q
);

	// Verilog code for the combinational circuit
	assign q = a & ~b;

endmodule
