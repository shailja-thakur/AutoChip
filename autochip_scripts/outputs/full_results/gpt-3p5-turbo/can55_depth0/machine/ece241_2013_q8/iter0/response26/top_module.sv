module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State definition
	typedef enum logic [1:0] {
		S,
		S1,
		S10
	} state_t;
	
	// Registers
	reg state_t state, next_state;
	
	always_ff @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			// Reset state to initial state
			state <= S;
		end else begin
			// State transition logic
			case (state)
				S: begin
					if (x == 0) begin
						next_state <= S;
					end else begin
						next_state <= S1;
					end
				end
				S1: begin
					if (x == 0) begin
						next_state <= S10;
					end else begin
						next_state <= S1;
					end
				end
				S10: begin
					if (x == 0) begin
						next_state <= S;
					end else begin
						next_state <= S1;
					end
				end
				default: next_state <= S; // Default case
			endcase
		end
	end
	
	always_comb begin
		case (state)
			S, S1: z = 0;
			S10: z = x;
		endcase
	end
	
endmodule
