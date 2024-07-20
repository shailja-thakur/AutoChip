module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

  // Use signed type for a and b
  reg signed [7:0] a_signed;
  reg signed [7:0] b_signed;

  // Assign input values to signed variables
  always @(a, b)
    begin
      a_signed = a;
      b_signed = b;
    end

  // Perform addition
  always @(a_signed, b_signed)
    begin
      // Perform addition and assign result to s
      s = a_signed + b_signed;

      // Check for overflow
      if (s > 128 || s < -128)
        overflow = 1; // Overflow occurred
      else
        overflow = 0; // No overflow occurred
    end

endmodule
