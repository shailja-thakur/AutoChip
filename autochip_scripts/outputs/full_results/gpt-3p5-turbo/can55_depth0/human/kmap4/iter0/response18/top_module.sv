module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	case ({{c, d}, {a, b}})
		2'b00_00: out = 1'b0;
		2'b00_01: out = 1'b1;
		2'b00_10: out = 1'b0;
		2'b00_11: out = 1'b1;
		2'b01_00: out = 1'b1;
		2'b01_01: out = 1'b0;
		2'b01_10: out = 1'b1;
		2'b01_11: out = 1'b0;
		2'b10_00: out = 1'b1;
		2'b10_01: out = 1'b0;
		2'b10_10: out = 1'b1;
		2'b10_11: out = 1'b0;
		2'b11_00: out = 1'b0;
		2'b11_01: out = 1'b1;
		2'b11_10: out = 1'b0;
		2'b11_11: out = 1'b1;
	endcase
end

endmodule
