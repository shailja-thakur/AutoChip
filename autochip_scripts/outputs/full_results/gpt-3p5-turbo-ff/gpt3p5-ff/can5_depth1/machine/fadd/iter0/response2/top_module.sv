module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Intermediate wires
	wire s1;
	wire s2;
	wire s3;

	// Full Adder
	assign s1 = a ^ b;
	assign sum = s1 ^ cin;
	assign s2 = a & b;
	assign s3 = s1 & cin;
	assign cout = s2 | s3;
	    
endmodule
