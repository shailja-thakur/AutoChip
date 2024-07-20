module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

	reg Y2_next; // Next state for Y2

	always @(*) begin
		// Next-state logic for Y2
		case (y[3:1])
			3'b000: Y2_next = (w) ? 1'b0 : 1'b0; // A (0)
			3'b001: Y2_next = (w) ? 1'b0 : 1'b1; // B (0)
			3'b010: Y2_next = (w) ? 1'b1 : 1'b0; // C (0)
			3'b011: Y2_next = (w) ? 1'b1 : 1'b1; // D (0)
			3'b100: Y2_next = (w) ? 1'b0 : 1'b0; // E (1)
			3'b101: Y2_next = (w) ? 1'b1 : 1'b0; // F (1)
			default: Y2_next = 1'b0; // Default state
		endcase
	end

	always @(posedge clk) begin
		Y2 <= Y2_next; // Assign next state to Y2
	end

endmodule
