module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define states
typedef enum logic [3:0] {
	A,
	B,
	C,
	S10,
	S11,
	S20,
	S21,
	S22
} state_type;

// Current state variable
reg [3:0] current_state;

// Next state variable
reg [3:0] next_state;

// Output assignment variable
reg z_next;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// Reset to initial state A
		current_state <= A;
		z <= 0;
	end else begin
		case (current_state)
			A: begin
				if (s) begin
					// Transition to state B if s is asserted
					next_state <= B;
				end else begin
					// Remain in state A otherwise
					next_state <= A;
				end
			end
			B: begin
				if (w) begin
					// Transition to state S11 if w is asserted
					next_state <= S11;
				end else begin
					// Transition to state S10 otherwise
					next_state <= S10;
				end
			end
			C: begin
				if (w) begin
					// Transition to state S11 if w is asserted
					next_state <= S11;
				end else begin
					// Transition to state S10 otherwise
					next_state <= S10;
				end
			end
			S10: begin
				if (w) begin
					// Transition to state S21 if w is asserted
					next_state <= S21;
				end else begin
					// Transition to state S20 otherwise
					next_state <= S20;
				end
			end
			S11: begin
				if (w) begin
					// Transition to state S22 if w is asserted
					next_state <= S22;
				end else begin
					// Transition to state S21 otherwise
					next_state <= S21;
				end
			end
			S20: begin
				// Transition back to state B
				next_state <= B;
			end
			S21: begin
				if (w) begin
					// Transition to state C if w is asserted
					next_state <= C;
				end else begin
					// Transition back to state B otherwise
					next_state <= B;
				end
			end
			S22: begin
				if (w) begin
					// Transition back to state B if w is asserted
					next_state <= B;
				end else begin
					// Transition to state C otherwise
					next_state <= C;
				end
			end
		endcase
	end
	
	// Assign next state to current state
	current_state <= next_state;
	
	// Assign next output value to output
	z <= z_next;
end

endmodule
