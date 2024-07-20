module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000:
				if (w) Y2 = 1'b0; // A -> B
				else Y2 = 1'b0; // A -> A
			3'b001:
				if (w) Y2 = 1'b0; // B -> A
				else Y2 = 1'b1; // B -> B
			3'b010:
				if (w) Y2 = 1'b1; // C -> D
				else Y2 = 1'b0; // C -> C
			3'b011:
				if (w) Y2 = 1'b1; // D -> A
				else Y2 = 1'b0; // D -> C
			3'b100:
				if (w) Y2 = 1'b0; // E -> D
				else Y2 = 1'b1; // E -> E
			3'b101:
				if (w) Y2 = 1'b0; // F -> C
				else Y2 = 1'b1; // F -> D
			default: Y2 = 1'bz; // Default
		endcase
	end

endmodule
