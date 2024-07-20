module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// State encoding
	typedef enum reg [1:0] {
		S_LOW = 2'b00,       // Below s[1]
		S_MID1 = 2'b01,      // Between s[2] and s[1]
		S_MID2 = 2'b10,      // Between s[3] and s[2]
		S_HIGH = 2'b11       // Above s[3]
	} state_t;

	state_t state, next_state;
	reg [3:1] s_prev; // Previous sensor states

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S_LOW;
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
			s_prev <= 3'b000;
		end else begin
			state <= next_state;
			s_prev <= s;
		end
	end

	always_comb begin
		next_state = state;
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;
                
		case (state)
			S_LOW: begin     // Below s[1]
				fr3 = 1'b1;
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = 1'b1;
				if (s[1]) next_state = S_MID1;
			end
			S_MID1: begin    // Between s[2] and s[1]
				fr2 = 1'b1;
				fr1 = 1'b1;
				if (s[2]) 
					next_state = S_MID2;
				else if (!s[1]) 
					next_state = S_LOW;
			end
			S_MID2: begin    // Between s[3] and s[2]
				fr1 = 1'b1;
				if (s[3]) 
					next_state = S_HIGH;
				else if (!s[2]) 
					next_state = S_MID1;
			end
			S_HIGH: begin    // Above s[3]
				if (!s[3]) 
					next_state = S_MID2;
			end
		endcase

		// Determine dfr output
		if (next_state > state) begin
			dfr = 1'b1;
		end
	end

endmodule
