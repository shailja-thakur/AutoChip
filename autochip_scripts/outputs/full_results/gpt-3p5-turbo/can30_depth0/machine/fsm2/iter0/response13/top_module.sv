module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {A, B} state_type;
	
	// Define the state and next state signals
	reg state_type curr_state;
	reg state_type next_state;
	
	// Combinational always block to determine the next state
	always_comb begin
		case (curr_state)
			A: if (j) next_state = B; else next_state = A;
			B: if (k) next_state = A; else next_state = B;
		endcase
	end
	
	// Clocked always block to update the state
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	// Assign the output based on the current state
	assign out = (curr_state == B) ? 1'b1 : 1'b0;
	
endmodule
