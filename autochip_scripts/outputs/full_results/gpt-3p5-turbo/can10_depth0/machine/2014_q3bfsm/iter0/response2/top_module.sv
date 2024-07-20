module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // Initializing state to A
		else
			state <= next_state; // Transition to next state
	end

	always @* begin
		case (state)
			3'b000: begin
				if (x) // If x is high, transition to state B
					next_state = 3'b001;
				else // If x is low, stay in state A
					next_state = 3'b000;
			end
			3'b001: begin
				if (x) // If x is high, transition to state E
					next_state = 3'b100;
				else // If x is low, stay in state B
					next_state = 3'b001;
			end
			3'b010: begin
				if (x) // If x is high, transition to state B
					next_state = 3'b001;
				else // If x is low, stay in state C
					next_state = 3'b010;
			end
			3'b011: begin
				if (x) // If x is high, transition to state C
					next_state = 3'b010;
				else // If x is low, stay in state D
					next_state = 3'b011;
			end
			3'b100: begin
				if (x) // If x is high, stay in state E
					next_state = 3'b100;
				else // If x is low, transition to state D
					next_state = 3'b011;
			end
			default: next_state = 3'b000; // Default transition to state A
		endcase
	end

	always @(state) begin
		if (state == 3'b100 || state == 3'b101)
			z <= 1'b1; // Output is high when state is D or E
		else
			z <= 1'b0;
	end

endmodule
