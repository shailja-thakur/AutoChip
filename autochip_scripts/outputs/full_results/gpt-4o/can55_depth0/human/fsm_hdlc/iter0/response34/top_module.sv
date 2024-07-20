module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// FSM state encoding
	typedef enum reg [2:0] {
		STATE_IDLE = 3'd0,
		STATE_1 = 3'd1,
		STATE_2 = 3'd2,
		STATE_3 = 3'd3,
		STATE_4 = 3'd4,
		STATE_5 = 3'd5,
		STATE_6 = 3'd6,
		STATE_FLAG = 3'd7
	} state_t;
	
	state_t current_state, next_state;
	
	// FSM state update
	always @(posedge clk) begin
		if (reset) begin
			current_state <= STATE_IDLE;
		end else begin
			current_state <= next_state;
		end
	end
	
	// FSM next state logic
	always @(*) begin
		next_state = STATE_IDLE;
		case (current_state)
			STATE_IDLE: begin
				if (in) next_state = STATE_1;
				else next_state = STATE_IDLE;
            end
			STATE_1: begin
				if (in) next_state = STATE_2;
				else next_state = STATE_IDLE;
            end
			STATE_2: begin
				if (in) next_state = STATE_3;
				else next_state = STATE_IDLE;
            end
			STATE_3: begin
				if (in) next_state = STATE_4;
				else next_state = STATE_IDLE;
            end
			STATE_4: begin
				if (in) next_state = STATE_5;
				else next_state = STATE_IDLE;
            end			
			STATE_5: begin
				if (in) next_state = STATE_6;
				else next_state = STATE_FLAG; // transition to FLAG after 5 consecutive 1's and a following 0
            end
			STATE_6: begin
				if (in) next_state = STATE_FLAG; // transition to FLAG after 6 consecutive 1's
				else next_state = STATE_IDLE;
            end
			STATE_FLAG: begin
				if (in) next_state = STATE_1;
				else next_state = STATE_IDLE;
            end
			default: begin
				next_state = STATE_IDLE;
			end
		endcase
	end
	
	// FSM output logic
	always @(posedge clk) begin
		if (reset) begin
			disc <= 0;
			flag <= 0;
			err <= 0;
		end else begin
			// Outputs default to 0
			disc <= 0;
			flag <= 0;
			err <= 0;

			case (current_state)
				STATE_5: begin
					if (~in) disc <= 1; // Output disc when encounter 0111110
				end
				STATE_FLAG: begin
					if (~in) flag <= 1; // Output flag when encounter 01111110
					else err <= 1; // Output err when encounter 01111111
				end
				default: begin
					// no output in other states
				end
			endcase
		end
	end
endmodule
