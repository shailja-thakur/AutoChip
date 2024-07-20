module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// Define state encoding
	typedef enum reg [1:0] {
		LOW_LEVEL = 2'b00,
		MID_LEVEL = 2'b01,
		HIGH_LEVEL = 2'b10,
		HIGHEST_LEVEL = 2'b11
	} state_t;
	
	state_t state, next_state;
	reg prev_level_lower;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW_LEVEL;
			prev_level_lower <= 1'b1;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic and output logic
	always @(*) begin
		// Default values
		next_state = state;
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;
		
		case (state)
			LOW_LEVEL: begin
				if (s == 3'b000) begin
					fr3 = 1'b1;
					fr2 = 1'b1;
					fr1 = 1'b1;
				end else if (s == 3'b001) begin
					next_state = MID_LEVEL;
					prev_level_lower = 1'b1;
				end
			end
			MID_LEVEL: begin
				if (s == 3'b001) begin
					fr2 = 1'b1;
					fr1 = 1'b1;
					dfr = prev_level_lower ? 1'b1 : 1'b0;
				end else if (s == 3'b011) begin
					next_state = HIGH_LEVEL;
					prev_level_lower = ~prev_level_lower;
				end else if (s == 3'b000) begin
					next_state = LOW_LEVEL;
					prev_level_lower = 1'b1;
				end
			end
			HIGH_LEVEL: begin
				if (s == 3'b011) begin
					fr1 = 1'b1;
					dfr = prev_level_lower ? 1'b1 : 1'b0;
				end else if (s == 3'b111) begin
					next_state = HIGHEST_LEVEL;
					prev_level_lower = ~prev_level_lower;
				end else if (s == 3'b001) begin
					next_state = MID_LEVEL;
					prev_level_lower = 1'b1;
				end
			end
			HIGHEST_LEVEL: begin
				if (s == 3'b111) begin
					// No flow control signals active
				end else if (s == 3'b011) begin
					next_state = HIGH_LEVEL;
					prev_level_lower = 1'b1;
				end
			end
		endcase
	end

endmodule
