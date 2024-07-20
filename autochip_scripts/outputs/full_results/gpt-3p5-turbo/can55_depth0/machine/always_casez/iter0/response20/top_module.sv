module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @* begin
		casez(in)
			8'b00000001: pos = 3'b0; // case when in is equal to 8'b00000001
			8'b00000101: pos = 3'b1; // case when in is equal to 8'b00000101
			8'b00001111: pos = 3'b2; // case when in is equal to 8'b00001111
			8'b00011101: pos = 3'b3; // case when in is equal to 8'b00011101
			8'b00111111: pos = 3'b4; // case when in is equal to 8'b00111111
			8'b01111111: pos = 3'b5; // case when in is equal to 8'b01111111
			8'b01111110: pos = 3'b6; // case when in is equal to 8'b01111110
			default: pos = 3'b0;      // default case
		endcase
	end

endmodule
