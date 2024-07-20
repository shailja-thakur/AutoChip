module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out
);

	always @(a or b or c or d) begin
		case ({c, d})
			2'b00:
				case ({a, b})
					2'b00: out <= 1;
					2'b01: out <= 0;
					2'b10: out <= 0;
					2'b11: out <= 1;
					default: out <= 1;
				endcase
			2'b01:
				case ({a, b})
					2'b00: out <= 0;
					2'b01: out <= 0;
					2'b10: out <= d;
					2'b11: out <= d;
					default: out <= d;
				endcase
			2'b10:
				case ({a, b})
					2'b00: out <= 0;
					2'b01: out <= 1;
					2'b10: out <= 1;
					2'b11: out <= 1;
					default: out <= 0;
				endcase
			2'b11:
				case ({a, b})
					2'b00: out <= 0;
					2'b01: out <= 1;
					2'b10: out <= 1;
					2'b11: out <= 1;
					default: out <= 1;
				endcase
		endcase
	end
	
endmodule
