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
			next_state <= A; // Fixed: Added next_state assignment
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
					end else begin
						next_state = B;
					end
				end
				C: begin
					if (in) begin
						next_state = D;
						out <= 0;
					end else begin
						next_state = A;
					end
				end
				D: begin
					if (in) begin
						next_state = B;
						out <= 1;
					end else begin
						next_state = C;
					end
				end
				default: next_state = A;
			endcase
		end
	end

endmodule
