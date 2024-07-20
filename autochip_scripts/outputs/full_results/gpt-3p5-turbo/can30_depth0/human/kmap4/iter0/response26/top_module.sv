module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
	always @(a or b or c or d) begin
		case ({a, b})
			2'b00: out = d;
			2'b01: out = ~c;
			2'b10: out = c;
			2'b11: out = ~d;
		endcase
	end
endmodule
