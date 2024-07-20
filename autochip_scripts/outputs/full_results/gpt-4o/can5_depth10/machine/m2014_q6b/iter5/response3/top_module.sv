module top_module(
	input [3:0] y,
	input w,
	output reg Y2);

	always @(*) begin
		case ({y, w}) // Combine y and w into a 5-bit input
			5'b00000, 5'b00001, 
			5'b01000, 5'b01100, 5'b01110, 5'b10000, 
			5'b11000: Y2 = 0;
			
			5'b00100, 5'b00110, 5'b01010, 
			5'b10010, 5'b10100, 5'b10110, 
			5'b11100: Y2 = 1;
			
			default : Y2 = 0;
		endcase
	end
	
endmodule
