module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // Initialize state to A
		else begin
			case (state)
				3'b000: // State A
					if (x)
						state <= 3'b001; // Transition to state B
					else
						state <= 3'b000; // Stay in state A
				3'b001: // State B
					if (x)
						state <= 3'b100; // Transition to state E
					else
						state <= 3'b001; // Stay in state B
				3'b010: // State C
					if (x)
						state <= 3'b001; // Transition to state B
					else
						state <= 3'b010; // Stay in state C
				3'b011: // State D
					if (x)
						state <= 3'b010; // Transition to state C
					else
						state <= 3'b001; // Stay in state B
				3'b100: // State E
					if (x)
						state <= 3'b100; // Stay in state E
					else
						state <= 3'b011; // Transition to state D
				default:
					state <= 3'b000;
			endcase
		end
	end

	always @(state) begin
		if (state == 3'b100 || state == 3'b101)
			z <= 1'b1; // Output is high when state is D or E
		else
			z <= 1'b0;
	end

endmodule
