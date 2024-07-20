module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// States
	typedef enum logic [2:0] {
		STATE_LOW = 3'b000,      // Below s[1]
		STATE_MID1 = 3'b001,     // Between s[2] and s[1]
		STATE_MID2 = 3'b010,     // Between s[3] and s[2]
		STATE_HIGH = 3'b011      // Above s[3]
	} state_t;

	state_t state, next_state;
	reg [3:0] previous_sensor_state;

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= STATE_LOW;
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 1;
		end else begin
			state <= next_state;

			// Update outputs based on state
			case (next_state)
				STATE_LOW: begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 1;
				end
				STATE_MID1: begin
					fr3 <= 0;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= (previous_sensor_state < 4'b0010) ? 1 : 0;
				end
				STATE_MID2: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 1;
					dfr <= (previous_sensor_state < 4'b0100) ? 1 : 0;
				end
				STATE_HIGH: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 0;
					dfr <= 0;
				end
			endcase

			// Update previous sensor state
			previous_sensor_state <= {previous_sensor_state[2:0], s[3:1]};
		end
	end

	always_comb begin
		next_state = state;
		case (s)
			3'b000: next_state = STATE_LOW;
			3'b001: next_state = STATE_MID1;
			3'b011: next_state = STATE_MID2;
			3'b111: next_state = STATE_HIGH;
			default: next_state = STATE_LOW;  // Default to low state for safety
		endcase
	end

endmodule
