module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @ (a or b or c or d)
begin
	// Implement the Karnaugh map
	case ({c, d})
		2'b00: out = a & b;
		2'b01: out = a ^ b;
		2'b10: out = ~(a & b);
		2'b11: out = ~(a ^ b);
	endcase
end

endmodule
