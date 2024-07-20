module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// States
	typedef enum logic [1:0] {
		LOW = 2'b00,
		MID_LOW = 2'b01,
		MID_HIGH = 2'b10,
		HIGH = 2'b11
	} state_t;
	
	state_t cur_state, next_state;
	reg previous_higher_level;
	
	// State transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			cur_state <= LOW;
			previous_higher_level <= 0;
		end else begin
			cur_state <= next_state;
			if (next_state > cur_state) begin
				previous_higher_level <= 1;
			end else begin
				previous_higher_level <= 0;
			end
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
		// Default output values
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;
		
		case (cur_state)
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
				// No flow rate
			end
		endcase
		
		if (previous_higher_level && cur_state != LOW && cur_state != HIGH) begin
			dfr = 1;
		end
	end
	
	// Explicit handling of reset in the output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 0;
		end else begin
			fr3 <= fr3;
			fr2 <= fr2;
			fr1 <= fr1;
			dfr <= dfr;
		end
	end

endmodule
