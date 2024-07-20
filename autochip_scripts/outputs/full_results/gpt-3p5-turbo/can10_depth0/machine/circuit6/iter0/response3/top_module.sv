module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @(*) begin
		case(a)
			3'b000: q = 16'b0100100011011010;  // Decimal equivalent of 4658
			3'b001: q = 16'b1010111101010000;  // Decimal equivalent of 44768
			3'b010: q = 16'b0010011111100100;  // Decimal equivalent of 10196
			3'b011: q = 16'b0101100110110110;  // Decimal equivalent of 23054
			3'b100: q = 16'b0010000110011010;  // Decimal equivalent of 8294
			3'b101: q = 16'b0110011000101110;  // Decimal equivalent of 25806
			3'b110: q = 16'b1100001110100110;  // Decimal equivalent of 50470
			3'b111: q = 16'b0010110010111001;  // Decimal equivalent of 12057
		endcase
	end

endmodule
