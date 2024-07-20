module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	typedef enum logic {
		B = 1'b0,
		A = 1'b1
	} state_t;

	state_t current_state, next_state;

	// State Transition
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= B;
		end else begin
			current_state <= next_state;
		end
	end

	// Next State Logic
	always_comb begin
		case (current_state)
			B: if (in) next_state = B;
				 else next_state = A;
			A: if (in) next_state = A;
				 else next_state = B;
			default: next_state = B;
		endcase
	end

	// Output Logic
	always_comb begin
		case (current_state)
			B: out = 1'b1;
			A: out = 1'b0;
			default: out = 1'b1;
		endcase
		end
endmodule
