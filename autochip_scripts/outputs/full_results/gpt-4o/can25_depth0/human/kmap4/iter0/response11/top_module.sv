module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	case ({c,d})
		2'b00: out = b;		// When c and d are 00, out = b
		2'b01: out = a;		// When c and d are 01, out = a
		2'b11: out = b;		// When c and d are 11, out = b
		2'b10: out = a;		// When c and d are 10, out = a
		default: out = 1'b0;  // Default value (shouldn't happen in this case)
	endcase
end

endmodule
