module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Declare internal wire signals
	wire [2:0] in_and;
	wire [2:0] in_xor;
	wire [2:0] in_and2;
	wire [2:0] out_xor;
	wire [2:0] sub_result;
	wire [2:0] y;
	
	// AND gate array
	assign in_and[2] = in[2];
	assign in_and[1] = in[1] & in_and[2];
	assign in_and[0] = in[0] & in_and[1];
	
	// XOR gate array
	assign in_xor[2] = in[2];
	assign in_xor[1] = in[1] ^ in_xor[2];
	assign in_xor[0] = in[0] ^ in_xor[1];
	
	// AND gate array for second stage
	assign in_and2[2] = in_xor[2];
	assign in_and2[1] = in_xor[1] & in_and2[2];
	assign in_and2[0] = in_xor[0] & in_and2[1];
	
	// XOR gate array for second stage
	assign out_xor[2] = in_and2[2];
	assign out_xor[1] = in_and2[1] ^ out_xor[2];
	assign out_xor[0] = in_and2[0] ^ out_xor[1];
	
	// Subtract 1 from output to get population count
	subtractor_3bit subtractor (
		.a(in_and),
		.b(out_xor),
		.sum(sub_result),
		.cout(y)
	);
	
	// Output the population count
	assign out = sub_result[1:0];
	
endmodule
module subtractor_3bit (
	input [2:0] a,
	input [2:0] b,
	output [2:0] sum,
	output cout
);
	assign {cout, sum} = a - b;
	
endmodule
