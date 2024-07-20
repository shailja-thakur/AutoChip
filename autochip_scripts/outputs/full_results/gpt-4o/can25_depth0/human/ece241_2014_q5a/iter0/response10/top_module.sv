module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		IDLE = 2'b00,
		INVERSE = 2'b01,
		ADD = 2'b10
	} state_t;
	
	state_t state, next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end
	
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 1'b0;
		end else begin
			case (state)
				IDLE: z <= 0;
				INVERSE: z <= ~x;
				ADD: z <= x & z;
			endcase
		end
	end

	always_comb begin
		next_state = state; // default to stay in the same state
		case (state)
			IDLE: if (!areset) next_state = INVERSE;
			INVERSE: next_state = ADD;
			ADD: if (areset) next_state = IDLE;
		endcase
	end

endmodule
