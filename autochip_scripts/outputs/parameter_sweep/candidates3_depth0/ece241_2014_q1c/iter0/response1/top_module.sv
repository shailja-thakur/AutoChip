module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Internal signals
	reg [8:0] sum;
	reg carry;
	
	// Adder logic
	always @(*) begin
		sum = a + b;
		carry = sum[8];
		s = sum[7:0];
	end
	
	// Overflow detection
	assign overflow = (a[7] ^ b[7]) & (s[7] ^ a[7]) & (s[7] ^ b[7]);
endmodule
