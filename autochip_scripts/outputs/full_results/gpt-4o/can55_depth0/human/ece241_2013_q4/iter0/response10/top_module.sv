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
	typedef enum reg [1:0] {
		LOW = 2'b00,
		MID_LOW = 2'b01,
		MID_HIGH = 2'b10,
		HIGH = 2'b11
	} state_t;
	
	state_t state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW;
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		// Default outputs
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;
		
		case (state)
			LOW: begin
				fr3 = 1'b1;
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = 1'b1;
				if (s[1]) next_state = MID_LOW;
			end
			MID_LOW: begin
				fr2 = 1'b1;
				fr1 = 1'b1;
				if (s[2]) next_state = MID_HIGH;
				else if (~s[1]) next_state = LOW;
			end
			MID_HIGH: begin
				fr1 = 1'b1;
				if (~s[2]) next_state = MID_LOW;
				else if (s[3]) next_state = HIGH;
			end
			HIGH: begin
				if (~s[3]) next_state = MID_HIGH;
			end
		endcase
		
		// Handle flow rate increase detection
		if (next_state > state)
			dfr = 1'b1;
		else
			dfr = 1'b0;
	end
endmodule
