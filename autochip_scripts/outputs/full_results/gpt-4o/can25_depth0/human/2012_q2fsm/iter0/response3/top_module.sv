module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State encoding
	typedef enum logic [2:0] {
		A = 3'd0,
		B = 3'd1,
		C = 3'd2,
		D = 3'd3,
		E = 3'd4,
		F = 3'd5
	} state_t;
	
	state_t state, next_state;

	// State flip-flops
	always @(posedge clk) begin
		if (reset) begin
			state <= A; // Reset to state A
		end else begin
			state <= next_state;
		end
	end

	// State table
	always @(*) begin
		case (state)
			A: begin
				if (w) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
			C: begin
				if (w) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			D: begin
				if (w) begin
					next_state = F;
				end else begin
					next_state = A;
				end
			end
			E: begin
				if (w) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			F: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
			default: begin
				next_state = A;
			end
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			D: z = 0;
			E: z = 1;
			F: z = 1;
			default: z = 0;
		endcase
	end

endmodule
