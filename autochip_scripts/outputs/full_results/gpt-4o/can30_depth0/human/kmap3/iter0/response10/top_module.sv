module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	case ({c,d,a,b})
	    4'b0000: out = 1'b0; // State 00 00
	    4'b0001: out = 1'b1; // State 00 01
	    4'b0010: out = 1'b0; // State 00 10
	    4'b0011: out = 1'b0; // State 00 11
	    4'b0100: out = 1'b0; // State 01 00
	    4'b0101: out = 1'b0; // State 01 01
	    4'b0110: out = 1'b1; // State 01 10
	    4'b0111: out = 1'b1; // State 01 11
	    4'b1000: out = 1'b1; // State 10 00
	    4'b1001: out = 1'b1; // State 10 01
	    4'b1010: out = 1'b1; // State 10 10
	    4'b1011: out = 1'b1; // State 10 11
	    4'b1100: out = 1'b1; // State 11 00
	    4'b1101: out = 1'b1; // State 11 01
	    4'b1110: out = 1'b1; // State 11 10
	    4'b1111: out = 1'b1; // State 11 11
	    default: out = 1'b0; // Default to 0 for don't care
	endcase
end

endmodule
