module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// FSM state encoding
	typedef enum logic [1:0] {
		LOW = 2'b00,	// Below s[1]
		MID = 2'b01,	// Between s[2] and s[1]
		HIGH = 2'b10,	// Between s[3] and s[2]
		FULL = 2'b11	// Above s[3]
	} state_t;

	state_t current_state, next_state;

	// Previous state for dfr logic
	reg [1:0] previous_state;

	// State transition logic (combinational)
	always @(*) begin
		case (current_state)
			LOW: begin
				if (s[1] & s[2] & s[3])
					next_state = FULL;
				else if (s[1] & s[2])
					next_state = HIGH;
				else if (s[1])
					next_state = MID;
				else
					next_state = LOW;
			end
			MID: begin
				if (s[1] & s[2] & s[3])
					next_state = FULL;
				else if (s[1] & s[2])
					next_state = HIGH;
				else if (!s[1])
					next_state = LOW;
				else
					next_state = MID;
			end
			HIGH: begin
				if (s[1] & s[2] & s[3])
					next_state = FULL;
				else if (!s[2])
					next_state = MID;
				else
					next_state = HIGH;
			end
			FULL: begin
				if (!s[3])
					next_state = HIGH;
				else
					next_state = FULL;
			end
			default: next_state = LOW; // Default to LOW state for safety
		endcase
	end

	// Output logic (combinational)
	always @(*) begin
		// Default outputs
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;

		case (current_state)
			LOW: begin
				fr3 = 1'b1;
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = 1'b1; // Assume the nominal max flow includes the supplemental flow (dfr on)
			end
			MID: begin
				fr2 = 1'b1;
				fr1 = 1'b1;
				if (previous_state == LOW)
					dfr = 1'b1; // Increase flow rate because the water level rose
			end
			HIGH: begin
				fr1 = 1'b1;
				if (previous_state == MID)
					dfr = 1'b1; // Increase flow rate because the water level rose
			end
			FULL: begin
				// No flow when the reservoir is full
			end
		endcase
	end

	// State registers (sequential)
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= LOW;
			previous_state <= LOW;
		end else begin
			previous_state <= current_state;
			current_state <= next_state;
		end
	end
endmodule
