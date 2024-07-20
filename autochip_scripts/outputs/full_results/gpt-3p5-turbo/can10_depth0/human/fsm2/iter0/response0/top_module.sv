module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define the state enumeration
	typedef enum [1:0] {OFF, ON} state;

	// Define the current state and next state variables
	reg state current_state, next_state;

	// Define the output reg
	reg out;

	// Define the synchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= OFF
		else
			current_state <= next_state;
	end

	// Define the next state logic
	always @(current_state, j, k) begin
		case (current_state)
			ON: begin
				if (k)
					next_state <= OFF;
				else
					next_state <= ON;
			end

			OFF: begin
				if (j)
					next_state <= ON;
				else
					next_state <= OFF;
			end
		endcase
	end

	// Define the output logic
	always @(current_state) begin
		case (current_state)
			ON: out <= 1;
			OFF: out <= 0;
			default: out <= 0;
		endcase
	end

endmodule
