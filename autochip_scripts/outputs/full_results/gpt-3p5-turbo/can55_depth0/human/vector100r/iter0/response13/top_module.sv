module top_module (
	input [99:0] in,
	output reg [99:0] out
);
	// Declare a temporary variable to store the reversed bits
	reg [99:0] temp;

	// Reverse the bit ordering by iterating over the input signal
	// and assigning the reversed bits to the temporary variable
	always @*
	begin
		for (int i = 0; i < 100; i = i + 1)
			temp[i] = in[99-i];
	end

	// Assign the reversed bits to the output
	always @*
	begin
		out = temp;
	end
endmodule
