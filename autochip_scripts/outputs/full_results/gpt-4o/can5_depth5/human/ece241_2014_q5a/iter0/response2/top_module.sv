module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0, // Initial state
		S1, // After first '1' detected
		S2  // After completing complement
	} state_t;
	
	state_t state, next_state;
	logic carry;  // Carry bit for 2's complement process

	// State transition logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) 
			state <= S0;
		else 
			state <= next_state;
	end

	// Next state logic and output logic
	always_comb begin
		next_state = state;
		z = x;  // Default output follows input
		
		case (state)
			S0: begin
				if (x == 1) begin
					carry = 1;
					z = ~x + carry;
					next_state = S1;
				end else begin
					z = x;
				end
			end
			
			S1: begin
				z = ~x + carry;
				carry = 0;  // Reset carry after use
				next_state = S1;
			end
			
			default: begin
				next_state = S0;
				z = x;  // Default safe value
			end
		endcase
	end

endmodule
