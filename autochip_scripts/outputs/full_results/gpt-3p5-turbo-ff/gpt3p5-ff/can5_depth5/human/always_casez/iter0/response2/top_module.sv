module top_module (
	input [7:0] in,
	output reg [2:0] pos
);
	
	// always block for detecting the first high bit
	always @(*) begin
		pos = 3'b0; // initialize the position to 0
		
		// loop through the input bits
		for (int i = 0; i < 8; i = i + 1) begin
			if (in[i] == 1'b1) begin
				pos = i; // update the position to the index of the first high bit
				break; // exit the loop once the first high bit is found
			end
		end
	end
endmodule
