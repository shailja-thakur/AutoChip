module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);

// Wire Declaration
wire [24:0] vector1;
wire [24:0] vector2;

// Assignment for vector1
assign vector1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

// Assignment for vector2
assign vector2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

// Output Assignment
assign out = vector1 ^ vector2;

endmodule
