module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// Registers for state and next_state
	reg [1:0] state, next_state;

	// State assignment
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else
			state <= next_state;
	end

	// Next state logic
	always @(state, j, k) begin
		case(state)
			0: begin  // State A
				if (j)
					next_state = 1;  // Transition to State B
				else
					next_state = 0;  // Stay in State A
			end
			1: begin  // State B
				if (k)
					next_state = 0;  // Transition to State A
				else
					next_state = 1;  // Stay in State B
			end
			default: next_state = 0;  // Default state assignment
		endcase
	end

	// Output assignment
	always @(state) begin
		if (state == 1)
			out = 1'b1;  // State B
		else
			out = 1'b0;  // State A
	end

endmodule
