module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		OFF = 1'b0,
		ON  = 1'b1
	} state_t;

	state_t state, next_state;

	// Asynchronous reset logic and state transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset) 
			state <= OFF; // Reset to OFF state
		else
			state <= next_state;
	end

	// State transition logic
	always_comb begin
		case (state)
			OFF: begin
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
			default: next_state = OFF;
		endcase
	end

	// Output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			out <= 1'b0; // Output is 0 in OFF state
		else
			case (state)
				OFF: out <= 1'b0;
				ON:  out <= 1'b1;
			endcase
	end

endmodule
