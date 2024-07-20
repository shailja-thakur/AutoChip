module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define the states
	typedef enum logic [2:0] {
		S,
		S1,
		S11,
		S110,
		Done
	} state_type;
	
	// Create registers for the state and next state
	reg state_type current_state;
	reg state_type next_state;
	
	// Assign the initial state
	always @(posedge reset)
	begin
		current_state <= S; // Reset to initial state
	end
	
	// Assign the next state based on current state and data input
	always @(posedge clk)
	begin
		case (current_state)
			S:
				if (data)
					next_state <= S1;
				else
					next_state <= S;
			S1:
				if (data)
					next_state <= S11;
				else
					next_state <= S;
			S11:
				if (data)
					next_state <= S11;
				else
					next_state <= S110;
			S110:
				if (data)
					next_state <= Done;
				else
					next_state <= S;
			Done:
				next_state <= Done;
		endcase
	end
	
	// Assign the output based on current state
	assign start_shifting = (current_state == Done) ? 1'b1 : 1'b0;
	
	// Update the current state
	always @(posedge clk)
	begin
		current_state <= next_state;
	end

endmodule
