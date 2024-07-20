module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @* begin
	// Iterate through the input vector
	for (int i = 0; i < 8; i = i + 1) begin
		// Check if the current bit is high
		if (in[i] == 1'b1) begin
			// Assign the position of the high bit to the pos output
			pos = i;
			// Exit the loop since we have found the first high bit
			break;
		end
	end
	
	// If no high bit was found, assign 0 to the pos output
	if (pos === 0) begin
		pos = 3'b0;
	end
end

endmodule
