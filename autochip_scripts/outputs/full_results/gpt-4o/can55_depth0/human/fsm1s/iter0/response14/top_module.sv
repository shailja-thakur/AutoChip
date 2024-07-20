module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define states
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// Sequential logic for state transitions
	always @(posedge clk) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	// Combinational logic for next state and output
	always @(*) begin
		case (state)
			B: begin
				out = 1;
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			A: begin
				out = 0;
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			default: begin
				out = 1; // Default output in case of undefined state
				next_state = B; // Default state
			end
		endcase
	end

endmodule
