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
	typedef enum logic [1:0] {
		LOW = 2'b00,
		MID_LOW = 2'b01,
		MID_HIGH = 2'b10,
		HIGH = 2'b11
	} state_t;

	state_t current_state, next_state;
	reg prev_level_lower;
	
	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= LOW;
			prev_level_lower <= 1'b0;
		end else begin
			current_state <= next_state;
			prev_level_lower <= (s < current_state);
		end
	end

	// Next state logic
	always @(*) begin
		case (s)
			3'b000: next_state = LOW;
			3'b001: next_state = MID_LOW;
			3'b011: next_state = MID_HIGH;
			3'b111: next_state = HIGH;
			default: next_state = LOW;
		endcase
	end

	// Output logic
	always @(*) begin
		// Default values
		fr1 = 1'b0;
		fr2 = 1'b0;
		fr3 = 1'b0;
		dfr = 1'b0;

		case (current_state)
			HIGH: begin
				// No outputs are asserted when the water level is above the highest sensor s[3]
			end
			MID_HIGH: begin
				fr1 = 1'b1;
				if (prev_level_lower)
					dfr = 1'b1;
			end
			MID_LOW: begin
				fr1 = 1'b1;
				fr2 = 1'b1;
				if (prev_level_lower)
					dfr = 1'b1;
			end
			LOW: begin
				fr1 = 1'b1;
				fr2 = 1'b1;
				fr3 = 1'b1;
			end
		endcase
	end

endmodule
