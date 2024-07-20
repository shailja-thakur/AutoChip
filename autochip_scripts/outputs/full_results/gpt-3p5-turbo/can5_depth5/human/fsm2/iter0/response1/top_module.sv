module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// state enumeration
	typedef enum logic [1:0] {OFF, ON} state_type;
	
	// state register and next state register
	reg state_type current_state, next_state;
	
	// output register
	reg out_reg;
	
	// Moore state machine logic
	always_ff @(posedge clk or posedge areset)
	begin
		if (areset) // asynchronous reset
		begin
			current_state <= OFF;
			out_reg <= 0;
		end
		else // state transitions
		begin
			current_state <= next_state;
			out_reg <= current_state;
		end
	end
	
	// next state logic
	always_comb
	begin
		case (current_state)
			OFF: if (j) next_state = ON; else next_state = OFF;
			ON: if (k) next_state = OFF; else next_state = ON;
			default: next_state = OFF;
		endcase
	end
	
	// output assignment
	assign out = out_reg;
	
endmodule
