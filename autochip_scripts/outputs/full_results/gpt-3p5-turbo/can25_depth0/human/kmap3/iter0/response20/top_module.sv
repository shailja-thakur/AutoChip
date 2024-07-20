module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

	always @* begin
		case({c, d, a, b})
			4'b00d0: out = 1'b1; // cdab = 00
			4'b0100: out = 1'b0; // cdab = 01
			4'b0101: out = 1'b1; // cdab = 01
			4'b0111: out = 1'b1; // cdab = 01
			4'b11d0: out = 1'b0; // cdab = 11
			4'b11d1: out = 1'b1; // cdab = 11
			4'b1110: out = 1'b1; // cdab = 11
			4'b1111: out = 1'b1; // cdab = 11
			default: out = 1'b0;
		endcase
	end
endmodule
