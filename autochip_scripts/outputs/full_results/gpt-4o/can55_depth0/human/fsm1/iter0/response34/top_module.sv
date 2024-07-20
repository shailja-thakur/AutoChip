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
	
	state_t state, next_state;
	
	// State transition on clock
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= B; // Asynchronously reset to state B
		else
			state <= next_state;
	end
	
	// Next-state logic
	always_comb begin
		case(state)
			A: next_state = (in) ? A : B;
			B: next_state = (in) ? B : A;
			default: next_state = B; // default state if undefined
		endcase
	end
	
	// Output logic
	always_comb begin
		case(state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b1;
		endcase
	end
	
endmodule
