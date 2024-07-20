module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// State machine states enumeration
	typedef enum reg [1:0] {
		LOW = 2'b00,
		MID_LOW = 2'b01,
		MID_HIGH = 2'b10,
		HIGH = 2'b11
	} state_t;
	
	state_t state, next_state;

	// Sequential logic for state transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW;
		end else begin
			state <= next_state;
		end
	end

	// Combinational logic for state transitions
	always @(*) begin
		case(state)
			LOW: begin
				if (s[1] && !s[2] && !s[3])
					next_state = MID_LOW;
				else if (s[1] && s[2] && !s[3])
					next_state = MID_HIGH;
				else if (s[1] && s[2] && s[3])
					next_state = HIGH;
				else
					next_state = LOW;
			end
			MID_LOW: begin
				if (!s[1] && !s[2] && !s[3])
					next_state = LOW;
				else if (s[1] && s[2] && !s[3])
					next_state = MID_HIGH;
				else if (s[1] && s[2] && s[3])
					next_state = HIGH;
				else
					next_state = MID_LOW;
			end
			MID_HIGH: begin
				if (!s[1] && !s[2] && !s[3])
					next_state = LOW;
				else if (s[1] && !s[2] && !s[3])
					next_state = MID_LOW;
				else if (s[1] && s[2] && s[3])
					next_state = HIGH;
				else
					next_state = MID_HIGH;
			end
			HIGH: begin
				if (!s[1] && !s[2] && !s[3])
					next_state = LOW;
				else if (s[1] && !s[2] && !s[3])
					next_state = MID_LOW;
				else if (s[1] && s[2] && !s[3])
					next_state = MID_HIGH;
				else
					next_state = HIGH;
			end
			default: next_state = LOW;
		endcase
	end

	// Combinational logic for output control
	always @(*) begin
		// Default output values
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;
		
		case(state)
			LOW: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
			end
			MID_LOW: begin
				fr2 = 1;
				fr1 = 1;
			end
			MID_HIGH: begin
				fr1 = 1;
			end
			HIGH: begin
				// No flow rates are asserted
			end
		endcase
		
		// Additional logic for dfr based on transitions
		if (state != LOW && next_state == MID_LOW ||
			state == MID_LOW && next_state == MID_HIGH ||
			state == MID_HIGH && next_state == HIGH) begin
			dfr = 1;
		end
	end

endmodule
