module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State Encoding
	typedef enum logic [1:0] {
		S_IDLE = 2'b00,
		S_INVERT = 2'b01,
		S_PROPAGATE = 2'b10
	} state_t;

	state_t state, next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) 
			state <= S_IDLE;
		else
			state <= next_state;
	end

	always_comb begin
		case (state)
			S_IDLE: begin
				if (x)
					next_state = S_INVERT;
				else
					next_state = S_IDLE;
				z = 1'b0;
			end

			S_INVERT: begin
				next_state = S_PROPAGATE;
				z = ~x;
			end

			S_PROPAGATE: begin
				if (x)
					next_state = S_PROPAGATE;
				else
					next_state = S_IDLE;
				z = ~x;
			end

			default: begin
				next_state = S_IDLE;
				z = 1'b0;
			end
		endcase
	end

endmodule
