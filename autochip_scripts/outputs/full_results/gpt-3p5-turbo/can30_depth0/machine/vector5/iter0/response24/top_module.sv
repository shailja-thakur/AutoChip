module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
	// Compute the first vector using bitwise negation and replication
	reg [24:0] vector1;
	assign vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
	
	// Compute the second vector using replication
	reg [24:0] vector2;
	assign vector2 = {5{a,b,c,d,e}};
	
	// Compute the final output by performing bitwise exclusive-or
	assign out = vector1 ^ vector2;
endmodule
