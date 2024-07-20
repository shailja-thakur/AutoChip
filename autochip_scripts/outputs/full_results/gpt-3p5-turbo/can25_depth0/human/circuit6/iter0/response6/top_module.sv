module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

always @(a) begin
	case (a)
		3'b000: q = 1232;
		3'b001: q = 0xaee0;
		3'b010: q = 0x27d4;
		3'b011: q = 0x5a0e;
		3'b100: q = 0x2066;
		3'b101: q = 0x64ce;
		3'b110: q = 0xc526;
		3'b111: q = 0x2f19;
	endcase
end

endmodule
