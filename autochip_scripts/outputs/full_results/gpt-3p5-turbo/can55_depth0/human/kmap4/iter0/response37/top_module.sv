module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(a or b or c or d) begin
	case({a,b})
		2'b00: out = 1'b0;
		2'b01: out = 1'b1;
		2'b10: out = 1'b1;
		default: out = 1'b0;
	endcase
end

endmodule
