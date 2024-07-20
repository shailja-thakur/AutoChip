module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// Define the states
	typedef enum logic [1:0] {
		LOW     = 2'b00, // All outputs asserted (low water level)
		MID_LOW = 2'b01, // fr1 and fr2 asserted (between s[2] and s[1])
		MID_HIGH= 2'b10, // fr1 asserted (between s[3] and s[2])
		HIGH    = 2'b11  // No outputs asserted (above s[3])
	} state_t;
	
	state_t state, next_state;
	// Variable to store the previous state to determine if we need to open the supplemental flow valve
	state_t previous_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW;
			previous_state <= LOW;
		end else begin
			state <= next_state;
			previous_state <= state;
		end
	end

	always @(*) begin
		// Default values for the outputs
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;

		case (state)
			LOW: begin
				fr3 = 1'b1;
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = 1'b0;
				if (s == 3'b000) begin
					next_state = LOW;
				end else if (s == 3'b001) begin
					next_state = MID_LOW;
				end else if (s == 3'b011) begin
					next_state = MID_HIGH;
				end else if (s == 3'b111) begin
					next_state = HIGH;
				end else begin
					next_state = LOW;
				end
			end

			MID_LOW: begin
				fr3 = 1'b0;
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = (previous_state == LOW) ? 1'b1 : 1'b0;
				if (s == 3'b000) begin
					next_state = LOW;
				end else if (s == 3'b011) begin
					next_state = MID_HIGH;
				end else if (s == 3'b111) begin
					next_state = HIGH;
				end else begin
					next_state = MID_LOW;
				end
			end

			MID_HIGH: begin
				fr3 = 1'b0;
				fr2 = 1'b0;
				fr1 = 1'b1;
				dfr = (previous_state == MID_LOW || previous_state == LOW) ? 1'b1 : 1'b0;
				if (s == 3'b000) begin
					next_state = LOW;
				end else if (s == 3'b001) begin
					next_state = MID_LOW;
				end else if (s == 3'b111) begin
					next_state = HIGH;
				end else begin
					next_state = MID_HIGH;
				end
			end

			HIGH: begin
				fr3 = 1'b0;
				fr2 = 1'b0;
				fr1 = 1'b0;
				dfr = 1'b0;
				if (s == 3'b000) begin
					next_state = LOW;
				end else if (s == 3'b001) begin
					next_state = MID_LOW;
				end else if (s == 3'b011) begin
					next_state = MID_HIGH;
				end else begin
					next_state = HIGH;
				end
			end

			default: begin
				next_state = LOW;
			end
		endcase
	end
endmodule
