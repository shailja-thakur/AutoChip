module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// States for the Moore state machine
	typedef enum reg [1:0] {
		S0, // First state after reset
		S1  // Invert bits and propagate carry
	} state_t;
	
	state_t state, next_state;
	reg carry;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
			z <= 0;
			carry <= 1;
		end else begin
			state <= next_state;
			if (state == S0) begin
				z <= ~x;  // Invert the bit
			end else if (state == S1) begin
				{carry, z} <= x + carry;  // Add carry to the input bit
			end
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			S0: next_state = S1;
			S1: next_state = S1;
			default: next_state = S0;
		endcase
	end

endmodule
