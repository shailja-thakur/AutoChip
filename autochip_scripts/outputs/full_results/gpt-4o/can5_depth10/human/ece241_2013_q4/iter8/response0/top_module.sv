module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	typedef enum reg [1:0] {
		STATE_LOW = 2'b00,
		STATE_MID = 2'b01,
		STATE_HIGH = 2'b10,
		STATE_TOP = 2'b11
	} state_t;

	// State registers
	reg [1:0] state, next_state;
	reg prev_level_higher; // Track if previous level was higher
	
	// Synchronization block for state transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= STATE_LOW;
			prev_level_higher <= 1'b0;
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end else begin
			state <= next_state;
			// Track if the previous level was lower
			prev_level_higher <= (next_state > state);
		end
	end

	// Next state logic
	always @(*) begin
		next_state = state; // Default state transition to current state
		case (state)
			STATE_LOW: begin
				if (s[1]) next_state = STATE_MID;
			end
			STATE_MID: begin
				if (s[2]) next_state = STATE_HIGH;
				else if (!s[1]) next_state = STATE_LOW;
			end
			STATE_HIGH: begin
				if (s[3]) next_state = STATE_TOP;
				else if (!s[2]) next_state = STATE_MID;
			end
			STATE_TOP: begin
				if (!s[3]) next_state = STATE_HIGH;
			end
		endcase
	end

	// Output logic
	always @(*) begin
		// Default all outputs to zero
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;

		// Set output signals based on the current state
		case (state)
			STATE_LOW: begin
				fr3 = 1'b1;
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = 1'b1;
			end
			STATE_MID: begin
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = prev_level_higher ? 1'b1 : 1'b0;
			end
			STATE_HIGH: begin
				fr1 = 1'b1;
				dfr = prev_level_higher ? 1'b1 : 1'b0;
			end
			STATE_TOP: begin
				// No flow rate enabled
			end
		endcase
	end

endmodule
