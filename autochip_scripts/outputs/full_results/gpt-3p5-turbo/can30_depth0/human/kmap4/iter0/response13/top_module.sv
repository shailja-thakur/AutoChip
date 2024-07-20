module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @ (a or b or c or d) begin
		case ({c, d, a, b})
			4'b0000, 4'b1111: out = 0;
			4'b0001, 4'b0110, 4'b1011, 4'b1100: out = 1;
			default: out = 0;
		endcase
	end
	
endmodule
