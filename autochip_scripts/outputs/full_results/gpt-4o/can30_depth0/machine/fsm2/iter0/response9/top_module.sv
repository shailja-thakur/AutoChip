module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// Define the states
	typedef enum reg {A, B} state_t;
	state_t state, next_state;
	
	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: begin
				if (j)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (k)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = A;
		endcase
	end
	
	// Sequential logic to update the state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A; // Reset to state A
		else
			state <= next_state;
	end
	
	// Output logic
	always @(state) begin
		case (state)
			A: out = 0;
			B: out = 1;
		endcase
	end

endmodule
