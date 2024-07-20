module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define states
	typedef enum logic [1:0] {
		A, B, C, D
	} state_t;

	reg state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
			next_state <= A;
			out <= 0;
		end else begin
			state <= next_state;
			case (state)
				A: begin
					if (in) begin
						next_state = B;
						out <= 0;
					end else begin
						next_state = A;
					end
				end
				B: begin
					if (in) begin
						next_state = C;
						out <= 0;
					end else if (state == B) begin  // Added condition to maintain state B
						next_state = B;
					end else if (state == C) begin  // Added condition for transition from C to B
						next_state = B;
					end 	
				end
				C: begin
					if (in) begin
						next_state = D;
						out <= 0;
					end else if (state == C) begin  // Added condition to maintain state C
						next_state = C;
					end else if (state == A) begin  // Added condition for transition from A to C
						next_state = C;
					end
				end
				D: begin
					if (in) begin
						next_state = B;
						out <= 1;
					end else if (state == C) begin  // Added condition for transition from C to D
						next_state = D;
					end else if (state == D) begin  // Added condition to maintain state D
						next_state = D;
					end 
				end
				default: next_state = A;
			endcase
		end
	end

endmodule
