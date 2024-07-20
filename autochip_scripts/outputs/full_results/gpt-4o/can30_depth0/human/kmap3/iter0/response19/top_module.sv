module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(*) begin
		case ({c, d, a, b})
			4'b0000: out = 1'b0; // state cdab = 0000
			4'b0001: out = 1'b0; // state cdab = 0001
			4'b0010: out = 1'b1; // state cdab = 0010
			4'b0011: out = 1'b1; // state cdab = 0011
			4'b0100: out = 1'b0; // state cdab = 0100
			4'b0101: out = 1'b0; // state cdab = 0101
			4'b0110: out = 1'b1; // state cdab = 0110
			4'b0111: out = 1'b1; // state cdab = 0111
			4'b1000: out = 1'b0; // state cdab = 1000
			4'b1001: out = 1'b1; // state cdab = 1001
			4'b1010: out = 1'b1; // state cdab = 1010
			4'b1011: out = 1'b1; // state cdab = 1011
			4'b1100: out = 1'b0; // state cdab = 1100
			4'b1101: out = 1'b1; // state cdab = 1101
			4'b1110: out = 1'b1; // state cdab = 1110
			4'b1111: out = 1'b1; // state cdab = 1111
			default: out = 1'bx; // undefined states (should never occur)
		endcase
	end
endmodule
