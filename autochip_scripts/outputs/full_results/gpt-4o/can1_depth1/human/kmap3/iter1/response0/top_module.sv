module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out
);
	always @(*) begin
		case ({c, d, a, b})
			4'b0000: out = 1'b0; // corresponds to K-map 00-00 -> 0
			4'b0001: out = 1'b0; // corresponds to K-map 00-01 -> 0
			4'b0010: out = 1'b1; // corresponds to K-map 00-10 -> 1
			4'b0011: out = 1'b1; // corresponds to K-map 00-11 -> 1
			4'b0100: out = 1'b0; // corresponds to K-map 01-00 -> 0
			4'b0101: out = 1'b0; // corresponds to K-map 01-01 -> 0
			4'b0110: out = 1'b0; // corresponds to K-map 01-10 -> 0
			4'b0111: out = 1'b0; // corresponds to K-map 01-11 -> 0
			4'b1000: out = 1'b0; // corresponds to K-map 10-00 -> 0
			4'b1001: out = 1'b1; // corresponds to K-map 10-01 -> 1
			4'b1010: out = 1'b1; // corresponds to K-map 10-10 -> 1
			4'b1011: out = 1'b1; // corresponds to K-map 10-11 -> 1
			4'b1100: out = 1'b0; // corresponds to K-map 11-00 -> 0
			4'b1101: out = 1'b1; // corresponds to K-map 11-01 -> 1
			4'b1110: out = 1'b1; // corresponds to K-map 11-10 -> 1
			4'b1111: out = 1'b1; // corresponds to K-map 11-11 -> 1 
			default: out = 1'b0; // default case, should not be encountered
		endcase
	end
endmodule
