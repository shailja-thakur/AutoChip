module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	// Enumeration for FSM states
	typedef enum {A, B} state_t;
	reg state_t current_state, next_state;
	
	// Combinational always block for determining next state
	always @*
	begin
		if (current_state == A)
		begin
			if (j)
				next_state = B;
			else
				next_state = A;
		end
		else // current_state == B
		begin
			if (k)
				next_state = A;
			else
				next_state = B;
		end
	end
	
	// Clocked always block for updating state
	always @(posedge clk)
	begin
		if (areset)
			current_state = A;
		else
			current_state = next_state;
	end
	
	// Assigning out port based on current state
	assign out = (current_state == B) ? 1'b1 : 1'b0;
	
endmodule
