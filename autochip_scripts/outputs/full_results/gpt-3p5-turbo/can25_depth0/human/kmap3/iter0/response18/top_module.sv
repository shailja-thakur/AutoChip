module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(a, b, c, d) begin
	case({c, a}):
		2'b00: out = 0;
		2'b01: out = 0;
		2'b10: out = 1;
		default: out = 1;
	endcase
end

endmodule
