module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Define states
	typedef enum logic [1:0] {
		S_IDLE,
		S_CONVERT,
		S_WAIT
	} state_t;
	
	// Define state register
	reg state_t current_state, next_state;
	
	// Define output register
	reg [31:0] z_reg;
	
	// Define combinational logic for next state and output generation
	always_comb begin
		case (current_state)
			S_IDLE:
				if (areset) begin
					next_state = S_IDLE;
					z_reg = 0;
				end
				else if (!areset && x) begin
					next_state = S_CONVERT;
					z_reg = -x;
				end
			S_CONVERT:
				if (!areset && !x) begin
					next_state = S_WAIT;
				end
			S_WAIT:
				if (!areset && x) begin
					next_state = S_CONVERT;
					z_reg = -x;
				end
		endcase
	end
	
	// Define sequential logic for state transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= S_IDLE;
		else
			current_state <= next_state;
	end
	
	// Assign output
	assign z = z_reg;
	
endmodule
