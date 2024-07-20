module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);
	
	// FSM states declaration
	typedef enum reg [1:0] {
		LOW,
		BETWEEN_LOW_MID,
		BETWEEN_MID_HIGH,
		HIGH
	} state_t;
	
	state_t state, next_state;
	
	// Reset and state transition logic
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			state <= LOW;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always @(*) begin
		case(state)
			LOW: begin
				if(s[1]) next_state = BETWEEN_LOW_MID;
				else next_state = LOW;
			end
			BETWEEN_LOW_MID: begin
				if(s[2]) next_state = BETWEEN_MID_HIGH;
				else if(~s[1]) next_state = LOW;
				else next_state = BETWEEN_LOW_MID;
			end
			BETWEEN_MID_HIGH: begin
				if(s[3]) next_state = HIGH;
				else if(~s[2]) next_state = BETWEEN_LOW_MID;
				else next_state = BETWEEN_MID_HIGH;
			end
			HIGH: begin
				if(~s[3]) next_state = BETWEEN_MID_HIGH;
				else next_state = HIGH;
			end
			default: next_state = LOW;
		endcase
	end
	
	// Output logic
	always @(*) begin
		// Default values for outputs
		fr1 = 0;
		fr2 = 0;
		fr3 = 0;
		dfr = 0;
		
		case(state)
			LOW: begin
				fr1 = 1;
				fr2 = 1;
				fr3 = 1;
			end
			BETWEEN_LOW_MID: begin
				fr1 = 1;
				fr2 = 1;
				dfr = 1;
			end
			BETWEEN_MID_HIGH: begin
				fr1 = 1;
				dfr = 1;
			end
			HIGH: begin
				// No flow rates assigned
			end
		endcase
	end
	
endmodule
