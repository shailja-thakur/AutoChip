module top_module (
	input [99:0] in,
	output reg [99:0] out
);

	// Variable to hold reversed bits
	reg [99:0] reversed;

	always @* begin
		// Reverse the bit ordering
		for (int i = 0; i < 100; i = i + 1) begin
			reversed[i] = in[99 - i];
		end
	end

	// Assign the reversed bits to the output
	assign out = reversed;

endmodule
