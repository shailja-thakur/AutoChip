module top_module (
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] s,
	output reg overflow
);

	always @(a or b) begin
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
		overflow = (sign_a == sign_b) && (sign_a != sign_s);

		// Assign the result by truncating to 8 bits
		s = s_full[7:0];
    end
    
endmodule
