module top_module (
	input [99:0] in,
	output reg [99:0] out
);

  // Variable to store the reversed vector
	reg [99:0] reversed;

	// Reversing the input vector
	always @* begin
		for (int i = 0; i < 100; i = i + 1) begin
			reversed[i] = in[99 - i];
		end
	end

	// Assigning the reversed vector to the output
	always @* begin
		out = reversed;
	end

endmodule
