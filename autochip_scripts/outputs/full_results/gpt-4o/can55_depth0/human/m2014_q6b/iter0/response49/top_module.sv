module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000: Y2 = 0;           // A (000)
			3'b001: Y2 = w;           // B (001)
			3'b010: Y2 = 0;           // C (010)
			3'b011: Y2 = ~w;          // D (011)
			3'b100: Y2 = 0;           // E (100)
			3'b101: Y2 = ~w & y[1];   // F (101)
			default: Y2 = 0;          // Default case for safety
		endcase
	end
endmodule
