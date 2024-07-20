module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(*) begin
		case ({c, d, a, b})
			4'b0010, // cd = 00, ab = 01
			4'b0011, // cd = 00, ab = 11
			4'b0101, // cd = 01, ab = 01
			4'b1010, // cd = 10, ab = 01
			4'b1011, // cd = 10, ab = 11
			4'b1100, // cd = 11, ab = 00
			4'b1101, // cd = 11, ab = 01
			4'b1110, // cd = 11, ab = 10
			4'b1111: // cd = 11, ab = 11
				out = 1;
			default:
				out = 0;
		endcase
	end
endmodule
