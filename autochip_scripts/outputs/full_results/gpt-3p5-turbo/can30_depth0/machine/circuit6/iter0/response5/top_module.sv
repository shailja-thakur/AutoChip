module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @*
	begin
		case(a)
			3'b000: q = 16'b0000001101101010;  // decimal value 4658
			3'b001: q = 16'b1010111010110000;  // decimal value 44768
			3'b010: q = 16'b0010100010000100;  // decimal value 10196
			3'b011: q = 16'b0101101101011110;  // decimal value 23054
			3'b100: q = 16'b0010000100011010;  // decimal value 8294
			3'b101: q = 16'b0110010100001110;  // decimal value 25806
			3'b110: q = 16'b1100001111000110;  // decimal value 50470
			3'b111: q = 16'b0010110011111001;  // decimal value 12057
			default: q = 16'b0;                // default value
		endcase
	end
endmodule
