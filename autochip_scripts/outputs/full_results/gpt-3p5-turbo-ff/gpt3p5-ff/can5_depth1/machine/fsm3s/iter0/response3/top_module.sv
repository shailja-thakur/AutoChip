module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;

	reg state_reg;
	state_t state_next, state_curr;
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= state_next;
		end else begin
			state_reg <= state_next;
		end
	end
	
	always_comb begin
		state_curr = state_reg;
		case(state_curr)
			A: begin
				if (in) begin
					state_next = B;
				end else begin
					state_next = A;
				end
			end
			B: begin
				if (in) begin
					state_next = B;
				end else begin
					state_next = C;
				end
			end
			C: begin
				if (in) begin
					state_next = D;
				end else begin
					state_next = A;
				end
			end
			D: begin
				if (in) begin
					state_next = B;
				end else begin
					state_next = C;
				end
			end
		endcase
	end
	
	assign out = (state_reg == D);

endmodule
