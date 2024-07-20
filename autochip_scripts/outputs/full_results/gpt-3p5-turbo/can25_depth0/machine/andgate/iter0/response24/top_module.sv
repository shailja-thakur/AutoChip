module top_module(
	input a, 
	input b,
	output out
);

	// Declare internal wire for AND gate
	wire temp;

	// Perform AND operation
	assign temp = a & b;

	// Drive output signal
	assign out = temp;
	
endmodule
