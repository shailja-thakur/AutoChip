module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	// State declaration
	typedef enum logic [1:0] {A, B} state_t;
	state_t state, next_state;

	// Combinational logic for next state
	always_comb begin
		case (state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
			default: next_state = A;
		endcase
	end

	// Sequential logic for state transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Output logic
	assign out = (state == B);

endmodule
