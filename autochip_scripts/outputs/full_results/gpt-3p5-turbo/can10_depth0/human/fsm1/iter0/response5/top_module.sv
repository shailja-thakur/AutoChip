module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State definition
	typedef enum logic [1:0] {
		A,
		B
	} state_t;
	
	// Registers
	reg state_t curr_state, next_state;
	
	// Outputs
	assign out = (curr_state == A) ? 1'b1 : 1'b0;
	
	// State transition logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			curr_state <= B;
		else
			curr_state <= next_state;
	end
	
	// Next state logic
	always_comb begin
		case (curr_state)
			A: begin
				case (in)
					0: next_state = B;
					1: next_state = A;
					default: next_state = curr_state;
				endcase
			end
			B: begin
				case (in)
					0: next_state = A;
					1: next_state = B;
					default: next_state = curr_state;
				endcase
			end
			default: next_state = curr_state;
		endcase
	end

endmodule
