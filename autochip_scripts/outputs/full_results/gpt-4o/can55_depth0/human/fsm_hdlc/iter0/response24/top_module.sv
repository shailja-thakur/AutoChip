module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum reg [3:0] {
		STATE_IDLE = 4'b0000,
		STATE_1 = 4'b0001,
		STATE_11 = 4'b0010,
		STATE_111 = 4'b0011,
		STATE_1111 = 4'b0100,
		STATE_11111 = 4'b0101,
		STATE_111110 = 4'b0110,
		STATE_1111110 = 4'b0111,
		STATE_11111110 = 4'b1000,
		STATE_11111111 = 4'b1001,
		STATE_ERROR = 4'b1010
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= STATE_IDLE;
		else
			state <= next_state;
	end

	// Next state logic and outputs
	always @ (*) begin
		// Default outputs
		disc = 0;
		flag = 0;
		err = 0;

		case (state)
			STATE_IDLE: begin
				if (in)
					next_state = STATE_1;
				else
					next_state = STATE_IDLE;
			end
			STATE_1: begin
				if (in)
					next_state = STATE_11;
				else
					next_state = STATE_IDLE;
			end
			STATE_11: begin
				if (in)
					next_state = STATE_111;
				else
					next_state = STATE_IDLE;
			end
			STATE_111: begin
				if (in)
					next_state = STATE_1111;
				else
					next_state = STATE_IDLE;
			end
			STATE_1111: begin
				if (in)
					next_state = STATE_11111;
				else
					next_state = STATE_IDLE;
			end
			STATE_11111: begin
				if (in)
					next_state = STATE_111110;
				else
					next_state = STATE_IDLE;
			end
			STATE_111110: begin
				if (in)
					next_state = STATE_1111110;
				else
					next_state = STATE_IDLE;
			end
			STATE_1111110: begin
				disc = 1; // Discard bit
				if (in)
					next_state = STATE_1111111;
				else
					next_state = STATE_IDLE;
			end
			STATE_1111111: begin
				if (in)
					next_state = STATE_11111110;
				else
					next_state = STATE_IDLE;
			end
			STATE_11111110: begin
				flag = 1; // Frame boundary
				if (in)
					next_state = STATE_11111111;
				else
					next_state = STATE_IDLE;
			end
			STATE_11111111: begin
				err = 1; // Error state
				if (in)
					next_state = STATE_ERROR;
				else
					next_state = STATE_IDLE;
			end
			STATE_ERROR: begin
				err = 1; // Remain in error state
				next_state = STATE_ERROR;
			end
			default: next_state = STATE_IDLE;
		endcase
	end
endmodule
