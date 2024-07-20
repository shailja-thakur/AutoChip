module top_module (
	input [99:0] in,
	output [99:0] out
);

	// Declare a temporary variable to store the reversed bits
	reg [99:0] temp;

	// Reverse the order of the bits
	always @* begin
		for (int i = 0; i < 100; i++) begin
			temp[i] = in[99 - i];
		end
	end

	// Assign the reversed bits to the output
	assign out = temp;

endmodule
