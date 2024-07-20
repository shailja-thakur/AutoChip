module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

// Priority Encoder
always @* begin
	case(in) 
		8'b00000001 : pos = 1'b0;   //bit 0 is high, so pos = 0
		8'b00000010 : pos = 1'b1;   //bit 1 is high, so pos = 1
		8'b00000100 : pos = 1'b2;   //bit 2 is high, so pos = 2
		8'b00001000 : pos = 1'b3;   //bit 3 is high, so pos = 3
		8'b00010000 : pos = 1'b4;   //bit 4 is high, so pos = 4
		8'b00100000 : pos = 1'b5;   //bit 5 is high, so pos = 5
		8'b01000000 : pos = 1'b6;   //bit 6 is high, so pos = 6
		8'b10000000 : pos = 1'b7;   //bit 7 is high, so pos = 7
		default     : pos = 3'd0;   //no bits are high, so pos = 0
	endcase
end

endmodule
