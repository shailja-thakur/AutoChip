module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State declaration
	typedef enum reg [1:0] {
		STATE_IDLE,     // Idle state when reset is asserted
		STATE_COMP      // Complement state
	} state_t;

	state_t state, next_state;
	reg bit_flipped;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_IDLE;
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		case (state)
			STATE_IDLE: begin
				if (!areset)
					next_state = STATE_COMP;
				else
					next_state = STATE_IDLE;
			end
			STATE_COMP: begin
				if (areset)
					next_state = STATE_IDLE;
				else
					next_state = STATE_COMP;
			end
		endcase
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 0;
			bit_flipped <= 0;
		end else begin
			if (state == STATE_COMP) begin
				if (bit_flipped) begin
					z <= ~x;
				end else begin
					z <= x;
					bit_flipped <= ~x;
				end
			end else begin
				z <= 0;
				bit_flipped <= 0;
			end
		end
	end

endmodule
