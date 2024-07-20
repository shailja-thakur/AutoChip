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
		LEVEL_LOWEST = 2'b00,
		LEVEL_MID_LOW = 2'b01,
		LEVEL_MID_HIGH = 2'b10,
		LEVEL_HIGHEST = 2'b11
	} state_t;

	reg [1:0] state, next_state;
	reg previous_rising_edge;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LEVEL_LOWEST;
			previous_rising_edge <= 0;
		end else begin
			state <= next_state;
			previous_rising_edge <= (state < next_state);
		end
	end

	always @(*) begin
		next_state = state; // Default next state
		case (state)
			LEVEL_LOWEST: begin
				if (s[1]) next_state = LEVEL_MID_LOW;
			end
			LEVEL_MID_LOW: begin
				if (s[2]) next_state = LEVEL_MID_HIGH;
				else if (!s[1]) next_state = LEVEL_LOWEST;
			end
			LEVEL_MID_HIGH: begin
				if (s[3]) next_state = LEVEL_HIGHEST;
				else if (!s[2]) next_state = LEVEL_MID_LOW;
			end
			LEVEL_HIGHEST: begin
				if (!s[3]) next_state = LEVEL_MID_HIGH;
			end
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 1;
		end else begin
			case (next_state)
				LEVEL_LOWEST: begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 1;
				end
				LEVEL_MID_LOW: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 1;
					dfr <= previous_rising_edge ? 1 : 0;
				end
				LEVEL_MID_HIGH: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 1;
					dfr <= previous_rising_edge ? 1 : 0;
				end
				LEVEL_HIGHEST: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 0;
					dfr <= 0;
				end
			endcase
		end
	end

endmodule
