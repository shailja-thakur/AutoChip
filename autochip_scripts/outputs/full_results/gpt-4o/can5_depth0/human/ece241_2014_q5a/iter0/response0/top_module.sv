module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'b00,  // Initial state
		S1 = 2'b01,  // First 1 is seen
		S2 = 2'b10   // Complementing state
	} state_t;
	
	state_t state, next_state;

	// Sequential logic for state transition
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end
	
	// Combinational logic for next state and output
	always @(*) begin
		case (state)
			S0: begin
				if (x == 1'b1) begin
					next_state = S1;
					z = 1'b0;
				} else begin
					next_state = S0;
					z = 1'b1;
				}
			end
			S1: begin
				next_state = S2;
				z = 1'b1;
			end
			S2: begin
				if (x == 1'b1) begin
					next_state = S2;
					z = 1'b1;
				} else begin
					next_state = S2;
					z = 1'b0;
				}
			end
			default: begin
				next_state = S0;
				z = 1'b1;
			end
		endcase
	end
endmodule
