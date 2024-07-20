module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// Define state parameters
	typedef enum reg {A, B} state_t;
	
	// Register to hold current state
	reg state, next_state;

	// Combinational always block to determine the next state
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

	// Clocked always block to update the state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A; // Reset state to A
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		if (state == B)
			out = 1;
		else
			out = 0;
	end

endmodule
