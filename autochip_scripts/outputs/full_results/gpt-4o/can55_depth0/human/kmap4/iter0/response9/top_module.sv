module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	case ({c,d})
		2'b00: out = b;   // For cd = 00
		2'b01: out = ~b;  // For cd = 01
		2'b11: out = b;   // For cd = 11
		2'b10: out = ~b;  // For cd = 10
	endcase
end

endmodule
