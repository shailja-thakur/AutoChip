module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	// Define the states
	enum state {OFF, ON};
	reg state current_state, next_state;
	
	// Define register for output
	reg out_reg;
	
	// Asynchronous reset
	always @(posedge areset)
	begin
		if (areset)
			current_state <= OFF;
		else
			current_state <= next_state;
	end
	
	// Sequential logic
	always @(posedge clk)
	begin
		if (areset)
			next_state <= OFF;
		else
		begin
			case (current_state)
				OFF:
					if (j)
						next_state <= ON;
					else
						next_state <= OFF;
				ON:
					if (k)
						next_state <= OFF;
					else
						next_state <= ON;
			endcase
		end
	end
	
	// Combinational logic
	always @*
	begin
		case (current_state)
			OFF: out_reg = 0;
			ON: out_reg = 1;
		endcase
	end
	
	// Assign output
	assign out = out_reg;
	
endmodule
