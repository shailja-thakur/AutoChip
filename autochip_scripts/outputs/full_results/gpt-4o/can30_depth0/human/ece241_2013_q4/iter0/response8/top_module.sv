module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);
	
	// State definitions for the water level
	typedef enum reg [1:0] {
		LOW = 2'b00,
		BETWEEN_LOW_AND_MID = 2'b01,
		BETWEEN_MID_AND_HIGH = 2'b10,
		HIGH = 2'b11
	} water_level_t;

	// State register
	reg [1:0] state, next_state;
	
	// Sequential logic for state register
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= LOW;
		else 
			state <= next_state;
	end
	
	// Combinational logic to determine next state and output
	always @(*) begin
		// Default values for outputs
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;
		
		case (state)
			LOW: begin
				if (s[3]) begin
					next_state = HIGH;
				end else if (s[2]) begin
					next_state = BETWEEN_MID_AND_HIGH;
				end else if (s[1]) begin
					next_state = BETWEEN_LOW_AND_MID;
				end else begin
					next_state = LOW;
				end
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
			end
			
			BETWEEN_LOW_AND_MID: begin
				if (s[3]) begin
					next_state = HIGH;
				end else if (s[2]) begin
					next_state = BETWEEN_MID_AND_HIGH;
				end else if (!s[1]) begin
					next_state = LOW;
				end else begin
					next_state = BETWEEN_LOW_AND_MID;
				end
				fr2 = 1;
				fr1 = 1;
				// Check if the previous state was lower
				if (state == LOW)
					dfr = 1;
			end
			
			BETWEEN_MID_AND_HIGH: begin
				if (s[3]) begin
					next_state = HIGH;
				end else if (!s[2]) begin
					if (s[1])
						next_state = BETWEEN_LOW_AND_MID;
					else
						next_state = LOW;
				end else begin
					next_state = BETWEEN_MID_AND_HIGH;
				end
				fr1 = 1;
				// Check if the previous state was lower
				if (state == BETWEEN_LOW_AND_MID || state == LOW)
					dfr = 1;
			end
			
			HIGH: begin
				if (!s[3]) begin
					if (s[2])
						next_state = BETWEEN_MID_AND_HIGH;
					else if (s[1])
						next_state = BETWEEN_LOW_AND_MID;
					else
						next_state = LOW;
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
