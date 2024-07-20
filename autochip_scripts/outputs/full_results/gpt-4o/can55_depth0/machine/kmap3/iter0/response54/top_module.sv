module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(*) begin
		case ({a, b, c, d})
			4'b0000, 
			4'b0001, 
			4'b0101, 
			4'b0111, 
			4'b0110: out = 1'b0; // a,b,c,d == 0, 1, 5, 7, 6

			4'b0011,
			4'b0010,
			4'b1100,
			4'b1111,
			4'b1110,
			4'b1000,
			4'b1011,
			4'b1010: out = 1'b1; // a,b,c,d == 3, 2, c, f, e, 8, b, a

			4'b0100,
			4'b1101,
			4'b1001: out = 1'bx; // a,b,c,d == 4, d, 9

			default: out = 1'b0;
		endcase
	end

endmodule
