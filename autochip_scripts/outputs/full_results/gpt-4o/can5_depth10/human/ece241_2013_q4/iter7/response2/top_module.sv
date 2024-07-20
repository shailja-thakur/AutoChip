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
		LOW_LEVEL = 2'b00,
		MID_LEVEL = 2'b01,
		HIGH_LEVEL = 2'b10,
		TOP_LEVEL = 2'b11
	} state_t;

	reg [1:0] state, next_state;
	reg prev_level_lower; // To keep track if the previous level was lower

	always @(posedge clk) begin
		if (reset) begin
			state <= LOW_LEVEL;
			prev_level_lower <= 1;
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 1;
		end else begin
			state <= next_state;
			prev_level_lower <= (next_state < state);
		end
	end

	always @(*) begin
		next_state = state; // Default state transition
		// Determine the next state based on sensors
		case (state)
			LOW_LEVEL: begin
				if (s[1]) next_state = MID_LEVEL;
			end
			MID_LEVEL: begin
				if (s[2]) next_state = HIGH_LEVEL;
				else if (!s[1]) next_state = LOW_LEVEL;
			end
			HIGH_LEVEL: begin
				if (s[3]) next_state = TOP_LEVEL;
				else if (!s[2]) next_state = MID_LEVEL;
			end
			TOP_LEVEL: begin
				if (!s[3]) next_state = HIGH_LEVEL;
			end
		endcase
	end

	always @(*) begin
		// Default all outputs
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;

		// Set output signals based on the current state
		case (state)
			LOW_LEVEL: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
				dfr = 1; // Supplemental flow valve should be opened
			end
			MID_LEVEL: begin
				fr2 = 1;
				fr1 = 1;
				if (prev_level_lower) dfr = 1; // Supplemental flow valve should be opened
			end
			HIGH_LEVEL: begin
				fr1 = 1;
				if (prev_level_lower) dfr = 1; // Supplemental flow valve should be opened
			end
			TOP_LEVEL: begin
				// No flow rate enabled
			end
		endcase
	end
endmodule
