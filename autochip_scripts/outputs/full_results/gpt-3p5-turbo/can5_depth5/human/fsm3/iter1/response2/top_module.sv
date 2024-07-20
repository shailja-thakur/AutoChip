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

	reg state_reg, next_state;
	reg out_reg;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= A;
			out_reg <= 0;
		end else begin
			state_reg <= next_state;
			out_reg <= out_reg;
		end
	end

	always_comb begin
		case (state_reg)
			A: begin
				if (in) begin
					next_state = B;
					out_reg = 0;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (in) begin
					next_state = B;
					out_reg = 0;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (in) begin
					next_state = D;
					out_reg = 0;
				end else begin
					next_state = A;
				end
			end
			D: begin
				if (in) begin
					next_state = B;
					out_reg = 1;
				end else begin
					next_state = C;
				end
			end
			default: next_state = A;
		endcase
	end

	assign out = out_reg;

endmodule
