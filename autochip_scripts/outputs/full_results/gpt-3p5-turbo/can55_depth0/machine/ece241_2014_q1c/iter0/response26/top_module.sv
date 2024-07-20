module top_module (
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] s,
	output reg overflow
);

	// Create a wire for the sum of a and b
	wire [7:0] sum;
	
	// Assign s to the 8 least significant bits of the sum
	assign s = sum[7:0];
	
	// Assign overflow using logical expression
	always @(*) begin
		if ((a[7] == b[7]) && (s[7] != a[7]))
			overflow = 1;
		else
			overflow = 0;
	end

	// Adder logic for sum
	assign sum = a + b;

endmodule
