module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);
	// Instantiate the adder module
	adder add_inst (.a(x), .b(y), .s(sum));

endmodule
module adder (
    input [3:0] a,
    input [3:0] b,
    output [4:0] s
);
	// Assign the sum of a and b to s
	assign s = a + b;

endmodule
