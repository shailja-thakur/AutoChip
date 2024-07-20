module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01
	} state_t;

	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			A: next_state = (in) ? A : B;
			B: next_state = (in) ? B : A;
			default: next_state = B; // Default state is B
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= B;
		else
			current_state <= next_state;
	end

	// Output logic based on state
	always @(*) begin
		case (current_state)
			A: out = 0;
			B: out = 1;
			default: out = 1; // Default state output is 1
		endcase
	end
	
endmodule
