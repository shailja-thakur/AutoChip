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
	typedef enum reg [1:0] {
		LOW = 2'b00,
		MID_LOW = 2'b01,
		MID_HIGH = 2'b10,
		HIGH = 2'b11
	} state_t;

	state_t current_state, next_state;
	reg [3:1] previous_s;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= LOW;
			previous_s <= 3'b000;
		end else begin
			current_state <= next_state;
			previous_s <= s;
		end
	end

	always @(*) begin
		case (current_state)
			LOW: begin
				if (s[1] == 1) 
					next_state = MID_LOW;
				else 
					next_state = LOW;
			end
			MID_LOW: begin
				if (s[2] == 1)
					next_state = MID_HIGH;
				else if (s[1] == 0)
					next_state = LOW;
				else
					next_state = MID_LOW;
			end
			MID_HIGH: begin
				if (s[3] == 1)
					next_state = HIGH;
				else if (s[2] == 0)
					next_state = MID_LOW;
				else
					next_state = MID_HIGH;
			end
			HIGH: begin
				if (s[3] == 0)
					next_state = MID_HIGH;
				else
					next_state = HIGH;
			end
			default: next_state = LOW;
		endcase
	end

	always @(*) begin
		// Default outputs
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;

		case (current_state)
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
				// No flow rate outputs asserted
			end
		endcase

		if (previous_s < s) begin
			// Water level increased, open supplemental flow valve
			dfr = 1;
		end
	end
	
endmodule
