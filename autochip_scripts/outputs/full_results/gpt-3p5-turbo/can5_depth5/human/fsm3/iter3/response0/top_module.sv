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

		end else begin
			state <= next_state;
			case (state)
				A: begin
					if (in) begin
						next_state <= B; // Fixed: Changed = to <= for non-blocking assignment
						out <= 0;
					end else begin
						next_state <= A; // Fixed: Changed = to <= for non-blocking assignment
					end
				end
				B: begin
					if (in) begin
						next_state <= C; // Fixed: Changed = to <= for non-blocking assignment
						out <= 0;
					end else begin
						next_state <= B; // Fixed: Changed = to <= for non-blocking assignment
					end
				end
				C: begin
					if (in) begin
						next_state <= D; // Fixed: Changed = to <= for non-blocking assignment
						out <= 0;
					end else begin
						next_state <= A; // Fixed: Changed = to <= for non-blocking assignment
					end
				end
				D: begin
					if (in) begin
						next_state <= B; // Fixed: Changed = to <= for non-blocking assignment
						out <= 1;
					end else begin
						next_state <= C; // Fixed: Changed = to <= for non-blocking assignment
					end
				end
				default: next_state <= A; // Fixed: Changed = to <= for non-blocking assignment
			endcase
		end
	end

endmodule
