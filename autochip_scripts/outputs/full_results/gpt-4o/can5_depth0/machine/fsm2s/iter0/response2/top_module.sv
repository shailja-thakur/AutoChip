module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg {A = 1'b0, B = 1'b1} state_t;
	state_t state, next_state;

	// Sequential logic: State transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A; // Initialize to state A on reset
		end
		else begin
			state <= next_state; // Transition to next state
		end
	end

	// Combinational logic: Next state logic
	always @(*) begin
		case (state)
			A: if (j) next_state = B;
			   else next_state = A;
			B: if (k) next_state = A;
			   else next_state = B;
			default: next_state = A; // Default to state A
		endcase
	end

	// Combinational logic: Output logic
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b0; // Default output when undefined state
		endcase
	end

endmodule
