module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Use a for loop to reverse the bit ordering
	// Iterate from 0 to 7
	genvar i;
	always @(*) begin
		for (i = 0; i < 8; i = i + 1) begin
			out[i] = in[7 - i];
		end
	end

endmodule
