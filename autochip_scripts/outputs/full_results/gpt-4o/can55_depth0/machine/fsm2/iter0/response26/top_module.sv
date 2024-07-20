module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {A = 1'b0, B = 1'b1} state_t;
	state_t state, next_state;

	// Combinational part: determine the next state
	always @(*) begin
		case (state)
			A: if (j) next_state = B; else next_state = A;
			B: if (k) next_state = A; else next_state = B;
			default: next_state = A; // Default state for safety
		endcase
	end

	// Sequential part: state update and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A; // Reset to state A
		end else begin
			state <= next_state; // Update state to next state
		end
	end

	// Output logic
	always @(*) begin
		out = (state == B); // out is high when in state B
		end
endmodule
