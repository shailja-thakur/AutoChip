module top_module (
	input [99:0] in,
	output reg [99:0] out
);

	// Implementing the bit reversal logic
	always @(*) begin
		for (int i = 0; i < 100; i = i + 1) begin
			out[i] = in[99 - i];
		end
	end

endmodule
