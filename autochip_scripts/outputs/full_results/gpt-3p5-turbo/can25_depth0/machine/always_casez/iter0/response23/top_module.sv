module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @(*) begin
		casez(in)
			8'bzzzzzzz1: pos <= 3'h0;
			8'bzzzzzzz0: pos <= 3'h1;
			8'bz1zzzzzz: pos <= 3'h6;
			8'bz0zzzzzz: pos <= 3'h7;
			8'bz0111111: pos <= 3'h2;
			8'bz0111110: pos <= 3'h3;
			8'bz0111101: pos <= 3'h4;
			8'bz0111100: pos <= 3'h5;
			default: pos <= 3'h0;
		endcase
	end

endmodule
