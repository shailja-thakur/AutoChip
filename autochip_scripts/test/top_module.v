module adder(
	input wire [3:0] a,
	input wire [3:0] b,
	output wire [3:0] sum
);

	assign sum = a + b;
endmodule
