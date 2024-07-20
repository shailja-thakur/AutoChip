module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum logic [3:0] {
		STATE_IDLE      = 4'b0000,
		STATE_ONE       = 4'b0001,
		STATE_TWO       = 4'b0010,
		STATE_THREE     = 4'b0011,
		STATE_FOUR      = 4'b0100,
		STATE_FIVE      = 4'b0101,
		STATE_SIX       = 4'b0110,
		STATE_FLAG      = 4'b0111,
		STATE_SEVEN     = 4'b1000,
		STATE_ERROR     = 4'b1001
	} state_t;
	
	state_t state, next_state;
	
	always_ff @(posedge clk) begin
		if (reset)
			state <= STATE_IDLE;
		else
			state <= next_state;
	end

	// Next state logic
	always_comb begin
		case (state)
			STATE_IDLE: begin
				if (in)
					next_state = STATE_ONE;
				else
					next_state = STATE_IDLE;
			end
			STATE_ONE: begin
				if (in)
					next_state = STATE_TWO;
				else
					next_state = STATE_IDLE;
			end
			STATE_TWO: begin
				if (in)
					next_state = STATE_THREE;
				else
					next_state = STATE_IDLE;
			end
			STATE_THREE: begin
				if (in)
					next_state = STATE_FOUR;
				else
					next_state = STATE_IDLE;
			end
			STATE_FOUR: begin
				if (in)
					next_state = STATE_FIVE;
				else
					next_state = STATE_IDLE;
			end
			STATE_FIVE: begin
				if (in)
					next_state = STATE_SIX;
				else
					next_state = STATE_IDLE;
			end
			STATE_SIX: begin
				if (in)
					next_state = STATE_SEVEN;
				else
					next_state = STATE_FLAG;
			end
			STATE_SEVEN: begin
				if (in)
					next_state = STATE_ERROR;
				else
					next_state = STATE_FLAG;
			end
			STATE_FLAG: begin
				if (in)
					next_state = STATE_ONE;
				else
					next_state = STATE_IDLE;
			end
			STATE_ERROR: begin
				if (reset)
					next_state = STATE_IDLE;
				else
					next_state = STATE_ERROR;
			end
			default: next_state = STATE_IDLE;
		endcase
	end

	// Output logic
	always_ff @(posedge clk) begin
		if (reset) begin
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
		end
		else begin
			disc <= 1'b0;
			flag <= 1'b0;
			err <= 1'b0;
			case (next_state)
				STATE_IDLE: begin
					disc <= 1'b0;
					flag <= 1'b0;
					err <= 1'b0;
				end
				STATE_FLAG: begin
					flag <= 1'b1;
				end
				STATE_SIX: begin
					if (!in)
						disc <= 1'b1;
				end
				STATE_ERROR: begin
					err <= 1'b1;
				end
				default: begin
					disc <= 1'b0;
					flag <= 1'b0;
					err <= 1'b0;
				end
			endcase
		end
	end

endmodule
