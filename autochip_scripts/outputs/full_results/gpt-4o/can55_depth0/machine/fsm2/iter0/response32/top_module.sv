module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	typedef enum logic {A, B} state_t;
	state_t current_state, next_state;

	// Output logic based on current state
	always_comb begin
		case (current_state)
			A: begin
				next_state = (j) ? B : A;
			end
			B: begin
				next_state = (k) ? A : B;
			end
			default: next_state = A;
		endcase
	end

	// Sequential logic to update current state
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Output assignment
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			out <= 1'b0;
		else
			out <= (current_state == B);
	end

endmodule
