module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		A, B, C, D
	} state_t;

	reg state, next_state;
	reg out_reg;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
			out_reg <= 0;
		end else begin
			state <= next_state;
			out_reg <= out_reg;
		end
	end

	always_comb begin
		case (state)
			A: begin
				if (in) begin
					next_state = B;
					out_reg = 0;
				end else begin
					next_state = A;
					out_reg = 0; // Added an assignment for out_reg in A state for the case when in is not true
				end
			end
			B: begin
				if (in) begin
					next_state = B;
					out_reg = 0;
				end else begin
					next_state = C;
					out_reg = 0; // Added an assignment for out_reg in B state for the case when in is not true
				end
			end
			C: begin
				if (in) begin
					next_state = D;
					out_reg = 0;
				end else begin
					next_state = A;
					out_reg = 0; // Added an assignment for out_reg in C state for the case when in is not true
				end
			end
			D: begin
				if (in) begin
					next_state = B;
					out_reg = 1;
				end else begin
					next_state = C;
					out_reg = 0; // Changed out_reg assignment to 0 for D state when in is not true
				end
			end
			default: next_state = A;
		endcase
	end

	assign out = out_reg;

endmodule
