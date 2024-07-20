module top_module (
	input [99:0] in,
	output reg [99:0] out
);

	// Declare temporary variables
	reg [99:0] reverse;
	
	// Assign the reversed bits to the reverse variable
	always @* begin
		for (int i = 0; i < 100; i = i + 1) begin
			reverse[i] = in[99 - i];
		end
	end
	
	// Assign the reverse variable to the output
	always @* begin
		out = reverse;
	end

endmodule
