module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*)
begin
	case ({c, d})
		2'b00: out = (b == 1'b0) ? 0 : 1;
		2'b01: out = (b == 1'b0) ? 1 : 0;
		2'b11: out = (b == 1'b0) ? 0 : 1;
		2'b10: out = (b == 1'b0) ? 1 : 0;
		default: out = 0; // for completeness, although not strictly necessary
	endcase
end

endmodule
