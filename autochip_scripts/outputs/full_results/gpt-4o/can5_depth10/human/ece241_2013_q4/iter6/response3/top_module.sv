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
		BETWEEN_LOW_MID = 2'b01,
		BETWEEN_MID_HIGH = 2'b10,
		HIGH_LEVEL = 2'b11
	} state_t;

	reg [1:0] state, next_state;
	reg prev_state_was_lower;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW_LEVEL;
			prev_state_was_lower <= 1'b0;
		end else begin
			state <= next_state;
			prev_state_was_lower <= (next_state < state);
		end
	end

	always @(*) begin
		next_state = state;
		case (state)
			LOW_LEVEL: begin
				if (s[1]) next_state = BETWEEN_LOW_MID;
			end
			BETWEEN_LOW_MID: begin
				if (s[2]) next_state = BETWEEN_MID_HIGH;
				else if (!s[1]) next_state = LOW_LEVEL;
			end
			BETWEEN_MID_HIGH: begin
				if (s[3]) next_state = HIGH_LEVEL;
				else if (!s[2]) next_state = BETWEEN_LOW_MID;
			end
			HIGH_LEVEL: begin
				if (!s[3]) next_state = BETWEEN_MID_HIGH;
			end
		endcase
	end

	always @(*) begin
		// Default all outputs
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;

		case (state)
			LOW_LEVEL: begin
				fr3 = 1'b1;
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = 1'b1;
			end
			BETWEEN_LOW_MID: begin
				fr2 = 1'b1;
				fr1 = 1'b1;
				if (prev_state_was_lower) dfr = 1'b1;
			end
			BETWEEN_MID_HIGH: begin
				fr1 = 1'b1;
				if (prev_state_was_lower) dfr = 1'b1;
			end
			HIGH_LEVEL: begin
				// No flow rate outputs enabled
			end
		endcase
	end
endmodule
