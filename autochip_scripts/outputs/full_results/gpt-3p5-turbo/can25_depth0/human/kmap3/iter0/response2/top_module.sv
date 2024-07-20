module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
	always @* begin
		case ({c, d, a, b})
			4'b00xx: out = 1;
			4'b010x: out = 1;
			4'b100x: out = 1;
			4'b11xx: out = 0;
			4'b01xx: out = 0;
			4'b111x: out = 1;
			default: out = 1;
		endcase
	end
endmodule
