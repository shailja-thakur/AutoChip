module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	
	// Define state encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
	
	// State registers
	state_t state, next_state;

	// State Transition Logic
	always @(*) begin
		case (state)
			A: if (in) next_state = B; else next_state = A;
			B: if (in) next_state = B; else next_state = C;
			C: if (in) next_state = D; else next_state = A;
			D: if (in) next_state = B; else next_state = C;
			default: next_state = A; // Default case to avoid latches
		endcase
	end

	// State Flip-Flops with Asynchronous Reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output Logic
	always @(*) begin
		case (state)
			A: out = 0;
			B: out = 0;
			C: out = 0;
			D: out = 1;
			default: out = 0;
		endcase
	end

endmodule
