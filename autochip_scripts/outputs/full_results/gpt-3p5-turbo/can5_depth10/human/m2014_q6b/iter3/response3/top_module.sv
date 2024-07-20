module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000: Y2 = (w & 1'b0); // A -> A (no change)
			3'b001: Y2 = (w & 1'b1); // B -> D (changed from C to D)
			3'b010: Y2 = (w & 1'b0); // C -> E (changed from E to C)
			3'b011: Y2 = (w & 1'b0); // D -> F (no change)
			3'b100: Y2 = (w & 1'b1); // E -> D (changed from E to D)
			3'b101: Y2 = (w & 1'b1); // F -> D (changed from C to D)
			default: Y2 = 1'b0; // Default
		endcase
	end

endmodule
