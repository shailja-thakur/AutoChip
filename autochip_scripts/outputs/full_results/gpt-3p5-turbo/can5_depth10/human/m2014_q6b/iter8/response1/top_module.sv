module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000: begin
				if (w) Y2 = 1'b0; // A -> B
				else Y2 = 1'b1; // A -> A
			end
			3'b001: begin
				if (w) Y2 = 1'b0; // B -> C
				else Y2 = 1'b0; // B -> D
			end
			3'b010: begin
				if (w) Y2 = 1'b1; // C -> E
				else Y2 = 1'b0; // C -> D
			end
			3'b011: begin
				if (w) Y2 = 1'b0; // D -> F
				else Y2 = 1'b0; // D -> A
			end
			3'b100: begin
				if (w) Y2 = 1'b0; // E -> E
				else Y2 = 1'b0; // E -> D
			end
			3'b101: begin
				if (w) Y2 = 1'b1; // F -> C
				else Y2 = 1'b0; // F -> D
			end
			default: Y2 = 1'b0; // Default
		endcase
	end

endmodule
