module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
	
	// Wire Declarations
	wire [4:0] vector1;
	wire [4:0] vector2;
	
	// XOR Vector1 with Vector2
	assign out = vector1 ^ vector2;
	
	// Assign Values to Vector1
	assign vector1[4:0] = ~{a, b, c, d, e};
	
	// Assign Values to Vector2
	assign vector2[4:0] = {a, b, c, d, e};
	
endmodule
