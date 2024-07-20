module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

	always @* begin
		case ({c, d})
			2'b00:
				case ({a, b})
					2'b00: out = 1;
					2'b01: out = 0;
					default: out = 1;
				endcase
			2'b01:
				case ({a, b})
					2'b10: out = d;
					default: out = d;
				endcase
			2'b10:
				case ({a, b})
					2'b10: out = 1;
					default: out = 0;
				endcase
			default:
				case ({a, b})
					2'b00: out = 0;
					default: out = 1;
				endcase
		endcase
	end
	
endmodule
