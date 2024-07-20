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

	always @(posedge clk) begin
		if (reset) 
			state <= LOW_LEVEL; // Reset to lowest level
		else
			state <= next_state;
	end

	always @(*) begin
		next_state = state; // Default state transition
		// Determine the next state based on sensors
		case(state)
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
		case(state)
			LOW_LEVEL: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
			end
			MID_LEVEL: begin
				fr2 = 1;
				fr1 = 1;
			end
			HIGH_LEVEL: begin
				fr1 = 1;
			end
			TOP_LEVEL: begin
				// No flow rate enabled
			end
		endcase
		
		// Determine if the supplemental flow valve should be opened
		if (next_state != state) begin
			case(next_state)
				LOW_LEVEL: dfr = (state < LOW_LEVEL);
				MID_LEVEL: dfr = (state < MID_LEVEL);
				HIGH_LEVEL: dfr = (state < HIGH_LEVEL);
				TOP_LEVEL: dfr = (state < TOP_LEVEL);
			endcase
		end else begin
			dfr = 0;
		end
	end
endmodule
