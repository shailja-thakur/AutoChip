module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Define internal signals
	reg [8:0] temp;
	wire [7:0] carry_in;
	wire carry_out;
	
	// Assign carry in and carry out signals
	assign carry_in = 1'b0;
	assign carry_out = temp[8];
	
	// Perform addition
	assign s = a + b + carry_in;
	
	// Check for overflow
	assign overflow = (a[7] == b[7] && s[7] != a[7]) || (a[7] != b[7] && s[7] == a[7]);

endmodule
