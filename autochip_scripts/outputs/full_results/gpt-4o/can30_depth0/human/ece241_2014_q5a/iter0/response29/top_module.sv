module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define state encoding
	typedef enum reg [1:0] {
		S0 = 2'b00,  // Initial state, awaiting Reset release
		S1 = 2'b01,  // After first 0 is received
		S2 = 2'b10   // After first 1 is received
	} state_t;
	
	reg [1:0] state, next_state;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			S0: next_state = x ? S2 : S1;  // If x is 0, go to S1; if x is 1, go to S2
			S1: next_state = S1;           // Stay in S1
			S2: next_state = S2;           // Stay in S2
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			S0: z = 1'b0;   // Output initially zero
			S1: z = ~x;     // Output the inversion of input x
			S2: z = ~x;     // Output the inversion of input x
			default: z = 1'b0; // Default case to avoid latches
		endcase
	end

endmodule
