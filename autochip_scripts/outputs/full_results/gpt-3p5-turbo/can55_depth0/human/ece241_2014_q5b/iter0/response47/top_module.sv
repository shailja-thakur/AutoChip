module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Define states
	typedef enum logic [1:0] {
		A,
		B
	} state_t;

	// Define signal and register variables
	reg state_t current_state, next_state;
	reg z_reg;
	wire z_next;
	
	// Assign initial state and output
	initial begin
		current_state = A;
		z_reg = 0;
	end
	
	// State transition and output logic
	always_ff @(posedge clk, posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
		
		case (current_state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
				
				z_next = x;
			end
			
			B: begin
				if (x)
					next_state = B;
				else
					next_state = B;
				
				z_next = ~x;
			end
		endcase
	end
	
	// Assign outputs
	always_comb begin
		z = z_reg;
	end
	
endmodule
