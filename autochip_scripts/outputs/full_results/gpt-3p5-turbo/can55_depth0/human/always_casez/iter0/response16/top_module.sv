module top_module (
	input [7:0] in,
	output reg [2:0] pos
);
	
	always @* begin
		// Initialize the position output to 0
		pos = 3'd0;
		
		// Iterate through the input vector
		for (int i = 0; i < 8; i = i + 1) begin
			// Check if the current bit is high
			if (in[i] == 1'b1) begin
				// Set the position output to the index of the first high bit
				pos = i;
				// Exit the loop
				break;
			end
		end
	end
	
endmodule
