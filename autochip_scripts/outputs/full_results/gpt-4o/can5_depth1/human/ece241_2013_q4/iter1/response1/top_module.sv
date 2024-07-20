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
		LOW = 2'b00,
		MID_LOW = 2'b01,
		MID_HIGH = 2'b10,
		HIGH = 2'b11
	} state_t;

	state_t state, next_state;

	always @(posedge clk) begin
		if (reset) begin
			state <= LOW;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		// Default values for outputs
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;
		
		// Default state is current state
		next_state = state;
		
		case (state)
			LOW: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
				if (s[1]) next_state = MID_LOW;
			end

			MID_LOW: begin
				fr1 = 1;
				fr2 = 1;
				if (s[2]) next_state = MID_HIGH;
				else if (!s[1]) next_state = LOW;
			end

			MID_HIGH: begin
				fr1 = 1;
				if (s[3]) next_state = HIGH;
				else if (!s[2]) next_state = MID_LOW;
			end

			HIGH: begin
				// No flow rate as water level is above the highest sensor
				if (!s[3]) next_state = MID_HIGH;
			end
		endcase

		// Determine if the Supplemental flow valve should be opened
		if ((next_state == MID_HIGH && state < MID_HIGH) ||
		    (next_state == HIGH && state < HIGH) ||
		    (next_state == MID_LOW && state < MID_LOW))
			dfr = 1; // Open Supplemental flow valve if water level is rising
	end

endmodule
