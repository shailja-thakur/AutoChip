module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out
);

	always @(*) begin
		case({c, d, a, b})
			4'b0000: out = 1;
			4'b0010: out = 1;
			4'b0111: out = 1;
			default: out = 0;
		endcase
	end
	
endmodule
