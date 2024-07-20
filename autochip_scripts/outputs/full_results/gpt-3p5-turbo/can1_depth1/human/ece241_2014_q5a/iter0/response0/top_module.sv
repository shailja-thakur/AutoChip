module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Define states
	typedef enum logic [1:0] {
		S_IDLE,
		S_CONVERT
	} state_t;
	
	// Define state register
	reg state_t current_state, next_state;
	
	// Define output register
	reg z_reg;
	
	// Define combinational logic for next state and output generation
	always_comb begin
		case (current_state)
			S_IDLE:
				if (areset) begin
					next_state = S_IDLE;
					z_reg = 2'b0;
				end
				else if (!areset && x) begin
					next_state = S_CONVERT;
					z_reg = ~x + 1;
				end
			S_CONVERT:
				if (!areset && !x) begin
					next_state = S_IDLE;
					z_reg = 2'b0;
				end
		endcase
	end
	
	// Define sequential logic for state transition
	always_ff @(posedge clk, posedge areset) begin
		if (areset)
			current_state <= S_IDLE;
		else
			current_state <= next_state;
	end
	
	// Assign output
	assign z = z_reg;
	
endmodule
