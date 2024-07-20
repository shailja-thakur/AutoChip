module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0, // Initial state (reset state)
		S1, // First 1 encountered
		S2  // Processing remaining bits after first 1
	} state_t;

	state_t state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			S0: begin
				if (x == 1'b1) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
			end
			
			S1: begin
				next_state = S2;
			end
			
			S2: begin
				next_state = S2;  // Stay in state S2 indefinitely
			end
			
			default: next_state = S0;
		endcase
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 1'b0;
		end else begin
			case (state)
				S0: z <= x;
				S1: z <= ~x;
				S2: z <= ~x;
				default: z <= 1'b0;
			endcase
		end
	end

endmodule
