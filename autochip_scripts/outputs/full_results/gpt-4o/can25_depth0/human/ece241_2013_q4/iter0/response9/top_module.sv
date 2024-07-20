module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// State machine states
	typedef enum reg [1:0] {
		LOW,
		MID_LOW,
		MID_HIGH,
		HIGH
	} state_t;

	state_t state, next_state;
	
	// Process to determine the next state based on current state and sensor inputs
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW; // Reset to the initial state
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			LOW: begin
				if (s[1]) 
					next_state = MID_LOW;
				else 
					next_state = LOW;
			end

			MID_LOW: begin
				if (s[2])
					next_state = MID_HIGH;
				else if (~s[1])
					next_state = LOW;
				else
					next_state = MID_LOW;
			end

			MID_HIGH: begin
				if (s[3])
					next_state = HIGH;
				else if (~s[2])
					next_state = MID_LOW;
				else
					next_state = MID_HIGH;
			end

			HIGH: begin
				if (~s[3])
					next_state = MID_HIGH;
				else
					next_state = HIGH;
			end

			default: begin
				next_state = LOW;
			end
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 1;
		end else begin
			case (state)
				LOW: begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
				end

				MID_LOW: begin
					fr3 <= 0;
					fr2 <= 1;
					fr1 <= 1;
					if (next_state == MID_LOW) // Staying in this state, so previously low
						dfr <= 1;
					else
						dfr <= 0;
				end

				MID_HIGH: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 1;
					if (next_state == MID_HIGH) // Staying in this state, so previously low
						dfr <= 1;
					else
						dfr <= 0;
				end

				HIGH: begin
					fr3 <= 0;
					fr2 <= 0;
					fr1 <= 0;
					dfr <= 0;
				end
			endcase
		end
	end
endmodule
