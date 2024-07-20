module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(*) begin
		casez ({c,d,a,b})
			4'b00?1: out = 1;
			4'b01?0: out = 1;
			4'b10?0: out = 1;
			4'b11?1: out = 1;
			default: out = 0;
		endcase
	end

endmodule
