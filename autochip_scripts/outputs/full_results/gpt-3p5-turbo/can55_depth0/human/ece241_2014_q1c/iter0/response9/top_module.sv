module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

	// Declare internal wires for intermediate calculations
	wire [8:0] sum;
	wire overflow;

	// Add the two numbers a and b to produce the sum
	assign sum = a + b;

	// Extract the result s[7:0] from the sum
	assign s = sum[7:0];

	// Determine whether an overflow has occurred
	assign overflow = (sum[8] != sum[7]);

endmodule
