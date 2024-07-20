module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @ (a or b or c or d) begin
	if (c == 0)
		case({a, b})
			2'b00: out = 0;
			2'b01: out = 0;
			2'b10: out = 0;
			2'b11: out = 0;
		endcase
	else if (c == 1)
		case({a, b})
			2'b00: out = 1;
			2'b01: out = d;
			2'b10: out = 1;
			2'b11: out = 1;
		endcase
	end
end

endmodule
