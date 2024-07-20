module top_module (
    input clk,
    input reset,
    input w,
    output z
);

	reg [2:0] state;

	always @(posedge clk, negedge reset)
	begin
		if (!reset)
			state <= 3'b000;   // Reset to state A
		else
			case (state)
				3'b000:    // State A
					if (w)
						state <= 3'b000;   // Transition to state A
					else
						state <= 3'b001;   // Transition to state B
				3'b001:    // State B
					if (w)
						state <= 3'b010;   // Transition to state D
					else
						state <= 3'b011;   // Transition to state C
				3'b010:    // State C
					if (w)
						state <= 3'b010;   // Transition to state C
					else
						state <= 3'b001;   // Transition to state B
				3'b011:    // State D
					if (w)
						state <= 3'b100;   // Transition to state A
					else
						state <= 3'b010;   // Transition to state C
				3'b100:    // State E
					if (w)
						state <= 3'b100;   // Transition to state E
					else
						state <= 3'b010;   // Transition to state C
				3'b101:    // State F
					if (w)
						state <= 3'b011;   // Transition to state C
					else
						state <= 3'b010;   // Transition to state C
				default:
					state <= 3'b000;   // Default to state A
			endcase
	end

	assign z = (state == 3'b101);   // Output z is 1 when state is F, otherwise 0

endmodule
