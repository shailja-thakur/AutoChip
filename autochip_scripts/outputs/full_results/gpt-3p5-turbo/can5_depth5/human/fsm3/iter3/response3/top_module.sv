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
					end else begin
						next_state = A;
					end
					out <= 0;
				end
				B: begin
					if (in) begin
						next_state = C;
					end else begin
						next_state = B;
					end
					out <= 0;
				end
				C: begin
					if (in) begin
						next_state = D;
					end else begin
						next_state = A;
					end
					out <= 0;
				end
				D: begin
					if (in) begin
						next_state = B;
					end else begin
						next_state = C;
					end
					out <= 1;
				end
				default: next_state = A;
			endcase
		end
	end

endmodule
