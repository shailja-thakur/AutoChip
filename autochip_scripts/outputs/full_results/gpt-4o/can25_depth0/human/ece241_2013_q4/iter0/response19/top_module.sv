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
		LOW_LEVEL = 2'b00,
		MEDIUM_LEVEL = 2'b01,
		HIGH_LEVEL = 2'b10,
		OVERFLOW = 2'b11
	} state_t;
	state_t state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW_LEVEL;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or s) begin
		case (state)
			LOW_LEVEL: begin
				if (s == 3'b000)
					next_state = LOW_LEVEL;
				else if (s == 3'b001)
					next_state = MEDIUM_LEVEL;
				else if (s == 3'b011)
					next_state = HIGH_LEVEL;
				else if (s == 3'b111)
					next_state = OVERFLOW;
				else
					next_state = state;
			end
			
			MEDIUM_LEVEL: begin
				if (s == 3'b000)
					next_state = LOW_LEVEL;
				else if (s == 3'b011)
					next_state = HIGH_LEVEL;
				else if (s == 3'b111)
					next_state = OVERFLOW;
				else
					next_state = state;
			end
			
			HIGH_LEVEL: begin
				if (s == 3'b000)
					next_state = LOW_LEVEL;
				else if (s == 3'b001)
					next_state = MEDIUM_LEVEL;
				else if (s == 3'b111)
					next_state = OVERFLOW;
				else
					next_state = state;
			end
			
			OVERFLOW: begin
				if (s == 3'b000)
					next_state = LOW_LEVEL;
				else if (s == 3'b001)
					next_state = MEDIUM_LEVEL;
				else if (s == 3'b011)
					next_state = HIGH_LEVEL;
				else
					next_state = state;
			end
			
			default: begin
				next_state = LOW_LEVEL;
			end
		endcase
	end

	always @(state or s) begin
		// Default values
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;

		case (state)
			LOW_LEVEL: begin
				fr3 = 1'b1;
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = 1'b1;
			end
			
			MEDIUM_LEVEL: begin
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = (s == 3'b000) ? 1'b1 : 1'b0;
			end
			
			HIGH_LEVEL: begin
				fr1 = 1'b1;
				dfr = (s == 3'b001 || s == 3'b000) ? 1'b1 : 1'b0;
			end
			
			OVERFLOW: begin
				// No flow rate outputs asserted
			end
			
			default: begin
				// Default fall-through, no action
			end
		endcase
	end
	
endmodule
