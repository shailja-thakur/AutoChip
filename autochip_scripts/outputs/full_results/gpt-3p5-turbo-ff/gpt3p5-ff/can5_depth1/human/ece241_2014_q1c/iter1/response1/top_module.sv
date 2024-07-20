module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Create intermediate wires for calculation
	reg [8:0] s_full;
	reg [8:0] result;
	reg sign_a, sign_b, sign_s;

	// Calculate the sign of inputs
	always @* begin
		sign_a = a[7];
		sign_b = b[7];
	end

	// Perform the addition
	always @* begin
		s_full = a + b;
	end

	// Calculate the sign of the sum
	always @* begin
		sign_s = s_full[8];
	end

	// Check for overflow by comparing signs
	always @* begin
		overflow = (sign_a == sign_b) && (sign_a != sign_s);
	end

	// Assign the result by truncating to 8 bits
	always @* begin
		s = s_full[7:0];
	end
    
endmodule
