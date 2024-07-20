module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @(*) begin
		case (a)
			3'b000: q = 16'b0100110100111010; // decimal value: 4658
			3'b001: q = 16'b1010111101000000; // decimal value: 44768
			3'b010: q = 16'b0010101001011100; // decimal value: 10196
			3'b011: q = 16'b0101101111101110; // decimal value: 23054
			3'b100: q = 16'b0010001001111010; // decimal value: 8294
			3'b101: q = 16'b0110011000111110; // decimal value: 25806
			3'b110: q = 16'b1100011010101110; // decimal value: 50470
			3'b111: q = 16'b0010110101111001; // decimal value: 12057
		endcase
	end

endmodule
