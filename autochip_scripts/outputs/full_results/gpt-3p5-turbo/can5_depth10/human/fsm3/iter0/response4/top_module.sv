module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states using an enumeration
	typedef enum logic [1:0] {
		A, B, C, D
	} state_type;
	
	// Define the state register and the next state 
	reg state_type curr_state, next_state;
	
	// Define the output register
	reg out_reg;
	
	// Assign the output based on the current state
	always_comb begin
		case (curr_state)
			A: out_reg = 0;
			B: out_reg = 0;
			C: out_reg = 0;
			D: out_reg = 1;
		endcase
	end
	
	// Define the state transition and output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset, reset to state A
			curr_state <= A;
		end else begin
			// Synchronous state update based on next state
			curr_state <= next_state;
		end
	end
	
	// Define the next state logic
	always_comb begin
		case (curr_state)
			A: if (in) next_state = B; else next_state = A;
			B: if (in) next_state = B; else next_state = C;
			C: if (in) next_state = D; else next_state = A;
			D: if (in) next_state = B; else next_state = C;
		endcase
	end
	
	// Assign the output
	assign out = out_reg;
	
endmodule
