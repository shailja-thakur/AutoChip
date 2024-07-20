module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// state encoding
	typedef enum logic [1:0] {
		LOW = 2'b00,
		MID = 2'b01,
		HIGH = 2'b10,
		OVER = 2'b11
	} state_t;

	state_t state, next_state;
	logic previous_level_higher;

	// state transition
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW;
			previous_level_higher <= 1'b0;
		end else begin
			state <= next_state;
			if (s[3] && !s[2] && !s[1])
				previous_level_higher <= 1'b1;
			else if (!s[3] && s[2] && !s[1])
				previous_level_higher <= 1'b0;
		end
	end

	// next state logic
	always_comb begin
		case (state)
			LOW: begin
				if (s[1] && s[2] && s[3])
					next_state = OVER;
				else if (s[1] && s[2])
					next_state = HIGH;
				else if (s[1])
					next_state = MID;
				else
					next_state = LOW;
			end
			MID: begin
				if (s[1] && s[2] && s[3])
					next_state = OVER;
				else if (s[1] && s[2])
					next_state = HIGH;
				else if (!s[1])
					next_state = LOW;
				else
					next_state = MID;
			end
			HIGH: begin
				if (s[1] && s[2] && s[3])
					next_state = OVER;
				else if (!s[2])
					next_state = MID;
				else
					next_state = HIGH;
			end
			OVER: begin
				if (!s[3])
					next_state = HIGH;
				else
					next_state = OVER;
			end
			default: next_state = LOW;
		endcase
	end

	// output logic
	always_comb begin
		fr1 = 1'b0;
		fr2 = 1'b0;
		fr3 = 1'b0;
		dfr = 1'b0;

		case (state)
			LOW: begin
				fr1 = 1'b1;
				fr2 = 1'b1;
				fr3 = 1'b1;
			end
			MID: begin
				fr1 = 1'b1;
				fr2 = 1'b1;
				if (previous_level_higher)
					dfr = 1'b1;
			end
			HIGH: begin
				fr1 = 1'b1;
				if (previous_level_higher)
					dfr = 1'b1;
			end
			OVER: begin
			end
			default: begin
			end
		endcase
	end

endmodule
