module top_module (
	input [7:0] in,
	output reg [2:0] pos
);
	
	always @(in) begin
		// Initialize position to 0
		pos <= 3'd0;
		
		// Loop through each bit of the input
		for (pos = 0; pos < 8; pos = pos + 1) begin
			// Check if the current bit is high
			if (in[pos] == 1) begin
				// Set the position to the index of the first high bit
				pos <= pos;
				// Exit the loop
				break;
			end
		end
	end
	
endmodule
