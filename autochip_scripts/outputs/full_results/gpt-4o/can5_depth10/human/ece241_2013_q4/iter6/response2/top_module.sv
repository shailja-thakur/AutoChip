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
		LEVEL_LOW = 2'b00,
		LEVEL_MID = 2'b01,
		LEVEL_HIGH = 2'b10,
		LEVEL_TOP = 2'b11
	} state_t;

	reg [1:0] state, next_state;
	reg prev_level_higher; // To keep track if the previous level was higher

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LEVEL_LOW;
			prev_level_higher <= 0;
		end else begin
			state <= next_state;
			// Determine if the last transition was to a higher level
			prev_level_higher <= (next_state > state);
		end
	end

	always @(*) begin
		next_state = state; // Default state transition
		// Determine the next state based on sensors
		case (state)
			LEVEL_LOW: begin
				if (s[1]) next_state = LEVEL_MID;
			end
			LEVEL_MID: begin
				if (s[2]) next_state = LEVEL_HIGH;
				else if (!s[1]) next_state = LEVEL_LOW;
			end
			LEVEL_HIGH: begin
				if (s[3]) next_state = LEVEL_TOP;
				else if (!s[2]) next_state = LEVEL_MID;
			end
			LEVEL_TOP: begin
				if (!s[3]) next_state = LEVEL_HIGH;
			end
		endcase
	end

	always @(*) begin
		// Default all outputs
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;

		// Set Nominal Flow Rate outputs based on the current state
		case (state)
			LEVEL_LOW: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
				dfr = 1; // Supplemental flow valve should be opened
			end
			LEVEL_MID: begin
				fr2 = 1;
				fr1 = 1;
				if (!prev_level_higher) dfr = 1; // Supplemental flow valve should be opened
			end
			LEVEL_HIGH: begin
				fr1 = 1;
				if (!prev_level_higher) dfr = 1; // Supplemental flow valve should be opened
			end
			LEVEL_TOP: begin
				// No flow rate enabled
			end
		endcase
	end
endmodule
