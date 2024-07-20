module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @(*) begin
		// Default value is 0
		pos = 3'b0;
		
		// Check each bit from least significant bit to most significant bit
		for (int i = 0; i < 8; i = i + 1) begin
			if (in[i] == 1'b1) begin
				pos = i;
				break;
			end
		end
	end
endmodule
