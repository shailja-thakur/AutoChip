module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @(*) begin
		case (a)
			0: q = 16'b0001001100110010;
			1: q = 16'b1010111001110000;
			2: q = 16'b0010011111000100;
			3: q = 16'b0101101111001110;
			4: q = 16'b0010000110011010;
			5: q = 16'b0111110111011110;
			6: q = 16'b1100001110010110;
			7: q = 16'b0010111011001001;
			default: q = 16'bz;
		endcase
	end

endmodule
