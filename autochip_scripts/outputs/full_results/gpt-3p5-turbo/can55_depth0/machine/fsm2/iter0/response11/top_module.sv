module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Declaring the states of the FSM
	parameter A = 1'b0;
	parameter B = 1'b1;

	// Registers to hold the current and next states
	reg state, next_state;

	// Assigning the initial state
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Combinational logic to determine the next state
	always @(state, j, k)
	begin
		case(state)
			A: 
				begin
					if (j)
						next_state = B;
					else
						next_state = A;
				end
			B:
				begin
					if (k)
						next_state = A;
					else
						next_state = B;
				end
		endcase
	end

	// Output assignment
	assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
