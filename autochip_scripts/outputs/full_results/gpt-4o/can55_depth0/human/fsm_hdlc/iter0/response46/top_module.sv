module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// Define states
	typedef enum logic [2:0] {
		STATE_IDLE     = 3'b000,
		STATE_ONE      = 3'b001,
		STATE_TWO      = 3'b010,
		STATE_THREE    = 3'b011,
		STATE_FOUR     = 3'b100,
		STATE_FIVE     = 3'b101,
		STATE_SIX      = 3'b110,
		STATE_SEVEN    = 3'b111
	} state_t;

	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk) begin
		if (reset)
			state <= STATE_IDLE;
		else
			state <= next_state;
	end

	// Next state logic and outputs
	always_comb begin
		// Default outputs
		disc = 1'b0;
		flag = 1'b0;
		err  = 1'b0;

		case (state)
			STATE_IDLE: begin
				if (in == 1'b1)
					next_state = STATE_ONE;
				else
					next_state = STATE_IDLE;
			end

			STATE_ONE: begin
				if (in == 1'b1)
					next_state = STATE_TWO;
				else
					next_state = STATE_IDLE;
			end

			STATE_TWO: begin
				if (in == 1'b1)
					next_state = STATE_THREE;
				else
					next_state = STATE_IDLE;
			end

			STATE_THREE: begin
				if (in == 1'b1)
					next_state = STATE_FOUR;
				else
					next_state = STATE_IDLE;
			end

			STATE_FOUR: begin
				if (in == 1'b1)
					next_state = STATE_FIVE;
				else
					next_state = STATE_IDLE;
			end

			STATE_FIVE: begin
				if (in == 1'b1)
					next_state = STATE_SIX;
				else
					next_state = STATE_IDLE;
			end

			STATE_SIX: begin
				if (in == 1'b0) begin
					disc = 1'b1;
					next_state = STATE_IDLE;
				end
				else
					next_state = STATE_SEVEN;
			end

			STATE_SEVEN: begin
				if (in == 1'b0) begin
					flag = 1'b1;
					next_state = STATE_IDLE;
				end
				else begin
					err = 1'b1;
					next_state = STATE_SEVEN;
				end
			end

			default: next_state = STATE_IDLE;
		endcase
	end
endmodule
