module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		OFF,
		ON
	} state_t;
	
	// Define state register
	reg state_t current_state, next_state;
	
	// Define output register
	reg out_reg;
	
	// Sequential logic process
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			current_state <= OFF;
		else
			current_state <= next_state;
	end
	
	// Combinational logic process
	always_comb
	begin
		// Default assignments
		next_state = current_state;
		out_reg = 0;
		
		// State transition conditions
		case (current_state)
			OFF:
				begin
					if (j)
						next_state = ON;
				end
				
			ON:
				begin
					if (!k)
						next_state = ON;
				end
		endcase
		
		// Output assignment
		if (current_state == ON)
			out_reg = 1;
	end
	
	// Assign output
	assign out = out_reg;
endmodule
