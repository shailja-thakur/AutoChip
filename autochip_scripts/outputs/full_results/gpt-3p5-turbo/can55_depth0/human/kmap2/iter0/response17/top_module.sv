module top_module ( 
input a,
input b,
input c,
input d,
output out
);

	// Implement the circuit described by the Karnaugh map

	// Define the intermediate signals
	wire x, y, z;

	// Implement the logic for the intermediate signals
	assign x = a & b;
	assign y = c & d;
	assign z = x | y;

	// Implement the output
	assign out = ~z;

endmodule
