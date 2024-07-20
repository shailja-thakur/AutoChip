module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000: Y2 = (w & 1'b0); // A -> B
			3'b001: Y2 = (w & 1'b0); // B -> C
			3'b010: Y2 = (w & 1'b0); // C -> E
			3'b011: Y2 = (w & 1'b1); // D -> F
			3'b100: Y2 = (w & 1'b0); // E -> E
			3'b101: Y2 = (w & 1'b0); // F -> C
			default: Y2 = 1'b0; // Default
		endcase
	end

endmodule
