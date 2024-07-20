module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	case ({c, d, a, b})
	4'b0010, // 00|10 -> 1
	4'b0011, // 00|11 -> 1
	4'b0100, // 01|00 -> 0
	4'b0101, // 01|01 -> 0
	4'b1000, // 10|00 -> 0
	4'b1001, // 10|01 -> 0
	4'b1010, // 10|10 -> 1
	4'b1011, // 10|11 -> 1
	4'b1101, // 11|01 -> 1
	4'b1110, // 11|10 -> 1
	4'b1111: // 11|11 -> 1
		out = 1'b1;
		
	default: out = 1'b0;  // Including the default for don't-cares and unspecified entries.
	endcase
end

endmodule
