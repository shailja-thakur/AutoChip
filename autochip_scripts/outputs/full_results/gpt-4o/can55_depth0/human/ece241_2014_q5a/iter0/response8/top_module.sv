module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum logic [1:0] {
		STATE_IDLE,
		STATE_INVERT,
		STATE_COPY
	} state_t;
	
	state_t current_state, next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= STATE_IDLE;
		end else begin
			current_state <= next_state;
		end
	end

	always_comb begin
		next_state = current_state;
		z = 1'b0;
		case (current_state)
			STATE_IDLE: begin
				if (!areset) begin
					next_state = STATE_INVERT;
				end
			end
			STATE_INVERT: begin
				z = ~x;
				if (x == 1'b1) begin
					next_state = STATE_COPY;
				end
			end
			STATE_COPY: begin
				z = x;
				if (areset) begin
					next_state = STATE_IDLE;
				end
			end
		endcase
	end

endmodule
