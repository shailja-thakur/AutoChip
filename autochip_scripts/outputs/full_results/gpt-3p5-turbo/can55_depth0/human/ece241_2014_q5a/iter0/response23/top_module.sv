module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// Define the states
	typedef enum logic [1:0] {
		IDLE,
		CONVERT
	} state_t;
	
	// Define the state register
	reg state_t current_state, next_state;
	
	// Define the output register
	reg z;
	
	// Define the input register
	reg x_reg;
	
	// Synchronous process (state register and output register)
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= IDLE;
		else
			current_state <= next_state;
		
		case (current_state)
			IDLE:
				if (!areset)
					z <= 1'b0;
			CONVERT:
				if (!areset)
					z <= ~x_reg + 1'b1;
		endcase
	end
	
	// Combinational process (next state and input register)
	always @(*) begin
		case (current_state)
			IDLE:
				next_state = x ? CONVERT : IDLE;
			CONVERT:
				next_state = x ? CONVERT : IDLE;
		endcase
		
		x_reg = x;
	end
	
endmodule
