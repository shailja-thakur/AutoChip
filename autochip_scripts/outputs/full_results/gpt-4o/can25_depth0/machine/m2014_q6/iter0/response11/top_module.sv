module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State Encoding
	typedef enum reg [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100,
		F = 3'b101
	} state_t;

	state_t current_state, next_state;

	// State Transition Logic
	always @(*) begin
		case (current_state)
			A: if (w) next_state = A; else next_state = B;
			B: if (w) next_state = D; else next_state = C;
			C: if (w) next_state = D; else next_state = E;
			D: if (w) next_state = A; else next_state = F;
			E: if (w) next_state = D; else next_state = E;
			F: if (w) next_state = D; else next_state = C;
			default: next_state = A;  // Default state transition
		endcase
	end

	// State Register
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
		end

	// Output Logic
	always @(*) begin
		case (current_state)
			E, F: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
