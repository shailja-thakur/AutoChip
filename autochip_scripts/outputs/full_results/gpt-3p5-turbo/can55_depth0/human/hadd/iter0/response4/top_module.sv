module top_module (
	input wire a,
	input wire b,
	output wire sum,
	output wire cout
);
	assign {sum, cout} = a + b;
endmodule
