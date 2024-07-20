module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Create intermediate wires for calculation
	wire [8:0] s_full;
	wire [8:0] result;
	wire sign_a, sign_b, sign_s;

	// Calculate the sign of inputs
	assign sign_a = a[7];
	assign sign_b = b[7];

	// Perform the addition
	assign s_full = a + b;

	// Calculate the sign of the sum
	assign sign_s = s_full[8];

	// Check for overflow by comparing signs
	assign overflow = (sign_a && sign_b && !sign_s) || (!sign_a && !sign_b && sign_s);

	// Assign the result by truncating to 8 bits
	assign s = s_full[7:0];
    
endmodule
