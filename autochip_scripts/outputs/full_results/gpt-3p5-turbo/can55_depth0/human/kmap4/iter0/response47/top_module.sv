module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	case ({c, d})
		2'b00:
			if ({a, b} == 2'b00 || {a, b} == 2'b11)
				out = 1'b0;
			else
				out = 1'b1;
		2'b01:
			if ({a, b} == 2'b01 || {a, b} == 2'b10)
				out = 1'b0;
			else
				out = 1'b1;
		2'b11:
			if ({a, b} == 2'b11 || {a, b} == 2'b00)
				out = 1'b0;
			else
				out = 1'b1;
		2'b10:
			if ({a, b} == 2'b10 || {a, b} == 2'b01)
				out = 1'b0;
			else
				out = 1'b1;
	endcase
end

endmodule
