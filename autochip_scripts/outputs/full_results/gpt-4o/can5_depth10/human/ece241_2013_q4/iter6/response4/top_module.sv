module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	typedef enum reg [2:0] {
		LOW_LEVEL = 3'b000,
		MID_LEVEL = 3'b001,
		HIGH_LEVEL = 3'b010,
		TOP_LEVEL = 3'b011
	} state_t;

	reg [2:0] state, next_state;
	reg [2:0] prev_state; // To keep track of the previous state

	always @(posedge clk) begin
		if (reset) begin
			state <= LOW_LEVEL;
			prev_state <= LOW_LEVEL;
		end else begin
			state <= next_state;
			prev_state <= state;
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
				if (prev_state < state) dfr = 1; // Supplemental flow valve should be opened
			end
			HIGH_LEVEL: begin
				fr1 = 1;
				if (prev_state < state) dfr = 1; // Supplemental flow valve should be opened
			end
			TOP_LEVEL: begin
				// No flow rate enabled
			end
		endcase
	end
endmodule
