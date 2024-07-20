module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Create internal wires and registers
reg sum;
wire cout;

// Implementation of full adder
assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
