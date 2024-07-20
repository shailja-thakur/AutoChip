module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	wire [7:0] sum;
	
	// Adder
	assign sum = a + b;
	
	// Output assignment
	assign s = sum[7:0];
	
	// Overflow assignment
	assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);
	
endmodule
