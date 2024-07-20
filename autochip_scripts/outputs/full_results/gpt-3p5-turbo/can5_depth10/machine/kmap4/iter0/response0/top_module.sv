module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out
);

	always @(a or b or c or d)
	begin
		case ({a, b, c, d})
			4'b0000: out = 1'b0;
			4'b1111: out = 1'b1;
			default: out = 1'b0;
		endcase
	end
	
endmodule
