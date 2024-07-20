module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @(in) begin
		// Initializing position to zero
		pos = 3'b0;
		// Loop to find the first bit that is high
		for (pos = 0; pos < 8; pos = pos + 1) begin
			if (in[pos] == 1'b1) begin
				// Break the loop if a bit is high
				break;
			end
		end
	end

endmodule
