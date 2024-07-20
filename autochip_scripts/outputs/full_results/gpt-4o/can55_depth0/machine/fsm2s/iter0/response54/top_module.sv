module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	typedef enum logic [0:0] {A=1'b0, B=1'b1} state_t;
	state_t state, next_state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A; // Initialize state to A upon reset
		else
			state <= next_state; // Transition to the next state
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 1'b0; // Output is low in state A
		else
			out <= (state == B) ? 1'b1 : 1'b0; // Output is high in state B
	end

endmodule
