module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
	always @* begin
		case ({c, d, a, b})
			4'b0010, 4'b0110, 4'b1000, 4'b1010, 4'b1100: out = 1;
			4'b0000, 4'b0011: out = 0;
			default: out = d;
		endcase
	end
endmodule
