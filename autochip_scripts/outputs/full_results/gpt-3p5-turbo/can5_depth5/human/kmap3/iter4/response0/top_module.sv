module top_module (
	input a,
	input b,
	input c,
	input d,
	output reg out
);

	reg [1:0] karnaugh_map [3:0][1:0] = {	// Define the Karnaugh map
		{1'b0, 1'b0},
		{1'bx, 1'b1},
		{1'b1, 1'b1},
		{1'b1, 1'b1}
	};

	always @(a or b or c or d) begin
		case ({c, d})
			2'b00:
				case ({a, b})
					2'b00: out <= karnaugh_map[0][0];
					2'b01: out <= karnaugh_map[0][1];
					default: out <= karnaugh_map[0][1];
				endcase
			2'b01:
				case ({a, b})
					2'b10: out <= karnaugh_map[1][0];
					default: out <= karnaugh_map[1][1];
				endcase
			2'b10:
				case ({a, b})
					2'b10: out <= karnaugh_map[2][0];
					default: out <= karnaugh_map[2][1];
				endcase
			2'b11:
				case ({a, b})
					2'b00: out <= karnaugh_map[3][0];
					default: out <= karnaugh_map[3][1];
				endcase
		endcase
	end
	
endmodule
