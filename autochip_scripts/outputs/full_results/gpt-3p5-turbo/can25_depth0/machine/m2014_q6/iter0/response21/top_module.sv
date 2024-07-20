module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	// State enumeration
	typedef enum logic [2:0] {
		A, B, C, D, E, F
	} state_t;
	
	// State register
	reg state_t current_state, next_state;
	
	// Output register
	reg z_reg;
	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
		case (current_state)
			A: begin
				if (w) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			B: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			D: begin
				if (w) begin
					next_state = A;
				end else begin
					next_state = F;
				end
			end
			E: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			F: begin
				if (w) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
			default: next_state = A;
		endcase
	end
	
	always_comb begin
		case (current_state)
			E, F: z_reg = 1'b1;
			default: z_reg = 1'b0;
		endcase
	end
	
	assign z = z_reg;
	
endmodule
