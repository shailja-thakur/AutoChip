module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {OFF, ON} state_type;
	
	// Define the current state and next state variables
	logic [1:0] current_state, next_state;
	
	// Define the output variable
	logic output_reg;
	
	// Synchronous process for state update
	always_ff @(posedge clk or posedge areset)
	begin
		if (areset)
			current_state <= OFF;
		else
			current_state <= next_state;
	end
	
	// Combinational process for next state logic and output generation
	always_comb
	begin
		case (current_state)
			OFF:
				if (j)
					next_state = ON;
				else
					next_state = OFF;
				output_reg = 0;
			ON:
				if (k)
					next_state = OFF;
				else
					next_state = ON;
				output_reg = 1;
		endcase
	end
	
	assign out = output_reg;
	
endmodule
