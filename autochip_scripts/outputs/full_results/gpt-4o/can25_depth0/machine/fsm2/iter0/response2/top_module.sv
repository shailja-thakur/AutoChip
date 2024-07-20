module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// State declaration
	typedef enum logic {A, B} state_t;
	state_t state, next_state;

	// State transition logic (combinational always block)
	always @(*) begin
		case (state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
			default: next_state = A;
		endcase
	end

	// State update logic (clocked always block)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;  // Reset state to A
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == B);

endmodule
