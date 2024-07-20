module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out
);

	always @(a, b, c, d) begin
		case({c, d})
			2'b00: begin
				case({a, b})
					2'b00: out <= 1'b1;
					2'b01: out <= 1'b0;
					2'b10: out <= 1'b0;
					2'b11: out <= 1'b0;
				endcase
			end
			2'b01: begin
				case({a, b})
					2'b00: out <= d;
					2'b01: out <= 1'b0;
					2'b10: out <= d;
					2'b11: out <= d;
				endcase
			end
			2'b10: begin
				case({a, b})
					2'b00: out <= d;
					2'b01: out <= d;
					2'b10: out <= d;
					2'b11: out <= d;
				endcase
			end
			2'b11: begin
				case({a, b})
					2'b00: out <= 1'b1;
					2'b01: out <= d;
					2'b10: out <= d;
					2'b11: out <= 1'b1;
				endcase
			end
		endcase
	end

endmodule
