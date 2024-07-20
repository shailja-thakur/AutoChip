module top_module(
  input [2:0] a,
  input [2:0] b,
  output reg [2:0] out_or_bitwise,  // Use reg type for outputs
  output reg out_or_logical,        // Use reg type for outputs
  output reg [5:0] out_not          // Use reg type for outputs
);

	// Bitwise OR of the two vectors
	assign out_or_bitwise = a | b;

	// Logical OR of the two vectors
	always @(*) begin
		if (a | b)
			out_or_logical = 1;
		else
			out_or_logical = 0;
	end

	// Inverse (NOT) of both vectors
	always @(*) begin
		out_not[2:0] = ~a;  // Inverse of a in the lower half
		out_not[5:3] = ~b;  // Inverse of b in the upper half
	end

endmodule
