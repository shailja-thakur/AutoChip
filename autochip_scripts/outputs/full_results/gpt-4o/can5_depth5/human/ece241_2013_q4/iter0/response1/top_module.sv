module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// State declaration
	typedef enum reg [1:0] {
		LOW = 2'b00,
		MID = 2'b01,
		HIGH = 2'b10,
		ABOVE = 2'b11
	} state_t;
	
	state_t current_state, next_state;
	
	// State transition logic
	always @(*) begin
		case (current_state)
			LOW: begin
				if (s[1]) next_state = MID;
				else next_state = LOW;
			end
			MID: begin
				if (s[2]) next_state = HIGH;
				else if (!s[1]) next_state = LOW;
				else next_state = MID;
			end
			HIGH: begin
				if (s[3]) next_state = ABOVE;
				else if (!s[2]) next_state = MID;
				else next_state = HIGH;
			end
			ABOVE: begin
				if (!s[3]) next_state = HIGH;
				else next_state = ABOVE;
			end
			default: next_state = LOW;
		endcase
	end
	
	// Output logic
	always @(*) begin
		case (current_state)
			LOW: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
				dfr = 0;
			end
			MID: begin
				fr3 = 0;
				fr2 = 1;
				fr1 = 1;
				dfr = (next_state == HIGH) ? 1 : 0;  // If going up, open supplemental flow valve
			end
			HIGH: begin
				fr3 = 0;
				fr2 = 0;
				fr1 = 1;
				dfr = (next_state == ABOVE) ? 1 : 0;  // If going up, open supplemental flow valve
			end
			ABOVE: begin
				fr3 = 0;
				fr2 = 0;
				fr1 = 0;
				dfr = 0;
			end
			default: begin
				fr3 = 0;
				fr2 = 0;
				fr1 = 0;
				dfr = 0;
			end
		endcase
	end
	
	// State register and reset logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= LOW;
		else
			current_state <= next_state;
		end

endmodule
