module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
	always @(a, b, c, d)
	begin
		case ({c, d, a, b})
			4'b0_0_0_0: out = 1'b0;
			4'b0_0_0_1: out = 1'b0;
			4'b0_0_1_0: out = 1'b1;
			4'b0_0_1_1: out = 1'b1;
			4'b0_1_0_0: out = 1'b1;
			4'b0_1_0_1: out = 1'b1;
			4'b0_1_1_0: out = 1'b1;
			4'b0_1_1_1: out = 1'b1;
			4'b1_0_0_0: out = 1'b1;
			4'b1_0_0_1: out = 1'b1;
			4'b1_0_1_0: out = 1'b1;
			4'b1_0_1_1: out = 1'b1;
			4'b1_1_0_0: out = 1'b1;
			4'b1_1_0_1: out = 1'b1;
			4'b1_1_1_0: out = 1'b1;
			4'b1_1_1_1: out = 1'b1;
		endcase
	end
endmodule
