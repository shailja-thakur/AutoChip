module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @(in) begin
		casez(in)
			8'b00000001: pos <= 3'b0;
			8'b10000000: pos <= 3'b1;
			8'b10000001: pos <= 3'b2;
			8'b10000011: pos <= 3'b3;
			8'b10000111: pos <= 3'b4;
			8'b10001111: pos <= 3'b5;
			8'b10011111: pos <= 3'b6;
			8'b10111111: pos <= 3'b7;
			8'b11111111: pos <= 3'b8;
			default: pos <= 3'b0;
		endcase
	end

endmodule
