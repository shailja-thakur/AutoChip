module top_module (
	input [7:0] in,
	output [7:0] out
);
	// Create a temporary variable to store the reversed bits
	reg [7:0] temp;

	// Reverse the bit ordering
	always @* begin
		temp[0] = in[7];
		temp[1] = in[6];
		temp[2] = in[5];
		temp[3] = in[4];
		temp[4] = in[3];
		temp[5] = in[2];
		temp[6] = in[1];
		temp[7] = in[0];
	end

	// Assign the reversed bits to the output
	assign out = temp;
endmodule
