module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	always @(*) begin
		case ({c, d, a, b})
			4'b0000, 4'b0100, 4'b1000, 4'b1100: out = 0;
			4'b0001, 4'b0011, 4'b0111, 4'b1001, 4'b1011, 4'b1101, 4'b1111: out = 1;
			4'b0010: out = 1; // CD = 00, AB = 10
			4'b0110: out = 0; // CD = 01, AB = 10 (Don't care; choosing 0)
			4'b1110: out = 1; // CD = 11, AB = 10 (Don't care; choosing 1)
			4'b1010: out = 1; // CD = 10, AB = 10
			default: out = 0; // assigning a default value
		endcase
	end

endmodule
