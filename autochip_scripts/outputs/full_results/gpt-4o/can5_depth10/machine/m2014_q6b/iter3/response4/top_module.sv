module top_module(
	input [3:0] y,
	input w,
	output reg Y2);

	always @(*) begin
		case ({y, w})
			5'b00000: Y2 = 0;
			5'b00001: Y2 = 0;
			5'b00010: Y2 = 1;
			5'b00011: Y2 = 1;
			5'b00100: Y2 = 0;
			5'b00101: Y2 = 1;
			5'b00110: Y2 = 0;
			5'b00111: Y2 = 0;
			5'b01000: Y2 = 0;
			5'b01001: Y2 = 0;
			5'b01010: Y2 = 1;
			5'b01011: Y2 = 1;
			5'b01100: Y2 = 0;
			5'b01101: Y2 = 1;
			5'b01110: Y2 = 0;
			5'b01111: Y2 = 0;
			5'b10000: Y2 = 0;
			5'b10001: Y2 = 1;
			5'b10010: Y2 = 1;
			5'b10011: Y2 = 1;
			5'b10100: Y2 = 0;
			5'b10101: Y2 = 1;
			5'b10110: Y2 = 0;
			5'b10111: Y2 = 0;
			default: Y2 = 0; // Default case to handle unexpected inputs
		endcase
	end

endmodule
