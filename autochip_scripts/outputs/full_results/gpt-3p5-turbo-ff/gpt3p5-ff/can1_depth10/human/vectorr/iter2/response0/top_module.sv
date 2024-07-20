module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Use a for loop to reverse the bit ordering
	// Iterate from 0 to 7
	integer i;
	always @(*) begin
		for (i = 0; i < 8; i = i + 1) begin
			out[7 - i] = in[i];
		end
	end

endmodule
