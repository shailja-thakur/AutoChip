module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	case ({a, b, c, d})
		4'b0000: out = 1'b0;
		4'b0001: out = 1'b0;
		4'b0011: out = 1'b1;
		4'b0010: out = 1'b1;
		4'b0100: out = 1'bx;
		4'b0101: out = 1'b0;
		4'b0111: out = 1'b0;
		4'b0110: out = 1'b0;
		4'b1100: out = 1'b1; // Assuming "c" means 1100 (12 in decimal)
		4'b1101: out = 1'bx; // Assuming "d" means 1101 (13 in decimal)
		4'b1111: out = 1'b1; // Assuming "f" means 1111 (15 in decimal)
		4'b1110: out = 1'b1; // Assuming "e" means 1110 (14 in decimal)
		4'b1000: out = 1'b1;
		4'b1001: out = 1'bx;
		4'b1011: out = 1'b1; // Assuming "b" means 1011 (11 in decimal)
		4'b1010: out = 1'b1; // Assuming "a" means 1010 (10 in decimal)
		default: out = 1'b0; // Default case to cover other cases, if needed.
	endcase
end

endmodule
