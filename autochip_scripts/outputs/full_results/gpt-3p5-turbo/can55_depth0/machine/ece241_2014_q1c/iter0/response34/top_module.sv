module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

wire [7:0] sum;

assign s = sum[7:0];

assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

// Adder module
// Instantiate an 8-bit adder with inputs a and b, and output sum
// assign sum = a + b;
// adder adder_inst(.a(a), .b(b), .sum(sum));
endmodule
