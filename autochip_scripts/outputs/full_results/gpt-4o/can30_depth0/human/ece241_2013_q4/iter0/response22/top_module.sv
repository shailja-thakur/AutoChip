module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// States for the FSM
	typedef enum reg [1:0] {
		STATE_LOW,          // Below s[1]
		STATE_BETWEEN_1_2,  // Between s[2] and s[1]
		STATE_BETWEEN_2_3,  // Between s[3] and s[2]
		STATE_ABOVE_3       // Above s[3]
	} state_t;

	reg [1:0] current_state, next_state;
	reg was_lower;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= STATE_LOW;
			was_lower <= 1'b1;
		end else begin
			current_state <= next_state;
			was_lower <= (s[1:0] > current_state);
		end
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			STATE_LOW: if (s[1]) next_state = STATE_BETWEEN_1_2;
			STATE_BETWEEN_1_2:
				if (s[2]) next_state = STATE_BETWEEN_2_3;
				else if (!s[1]) next_state = STATE_LOW;
			STATE_BETWEEN_2_3:
				if (s[3]) next_state = STATE_ABOVE_3;
				else if (!s[2]) next_state = STATE_BETWEEN_1_2;
			STATE_ABOVE_3:
				if (!s[3]) next_state = STATE_BETWEEN_2_3;
		endcase
	end

	// Output logic
	always @(*) begin
		case (current_state)
			STATE_LOW: begin
				fr1 = 1;
				fr2 = 1;
				fr3 = 1;
				dfr = 0;
			end
			STATE_BETWEEN_1_2: begin
				fr1 = 1;
				fr2 = 1;
				fr3 = 0;
				dfr = was_lower;
			end
			STATE_BETWEEN_2_3: begin
				fr1 = 1;
				fr2 = 0;
				fr3 = 0;
				dfr = was_lower;
			end
			STATE_ABOVE_3: begin
				fr1 = 0;
				fr2 = 0;
				fr3 = 0;
				dfr = 0;
			end
		endcase
	end

endmodule
