module top_module (
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] s,
	output reg overflow
);

	// Wire declaration for intermediate signals
	wire carry;

	// Adder
	assign s = a + b;
	assign carry = (a[7] & b[7]) | (a[7] & ~s[7]) | (b[7] & ~s[7]);

	// Overflow detection
	always @(a, b, s) begin
		overflow = carry ^ (s[7] & ~a[7] & ~b[7]);
	end

endmodule
