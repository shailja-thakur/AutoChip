module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @(*) begin
		pos = 0; // Initialize position to zero
		
		for (int i = 0; i < 8; i = i + 1) begin
			if (in[i] == 1'b1) begin
				pos = i; // Set position to index of first high bit
				break;
			end
		end
	end
	
endmodule
