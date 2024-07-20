module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000: Y2 = w; // A -> B
			3'b001: Y2 = 1'b0; // B -> C (0)
			3'b010: Y2 = 1'b0; // C -> E (0)
			3'b011: Y2 = 1'b1; // D -> F (1)
			3'b100: Y2 = 1'b1; // E -> E (1)
			3'b101: Y2 = 1'b0; // F -> C (0)
			default: Y2 = 1'b0; // Default (0)
		endcase
	end

endmodule
