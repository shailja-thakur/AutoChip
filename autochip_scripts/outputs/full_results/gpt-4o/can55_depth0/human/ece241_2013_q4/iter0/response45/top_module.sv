module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// Declare state registers
	reg [1:0] state, next_state;
	reg prev_level;

	// State encoding
	localparam LOW_LEVEL = 2'b00;
	localparam MID_LEVEL = 2'b01;
	localparam HIGH_LEVEL = 2'b10;
	localparam ABOVE_HIGH_LEVEL = 2'b11;

	// Sequential state transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW_LEVEL;
			prev_level <= 1'b0;
		end else begin
			state <= next_state;
			prev_level <= (s > state);  // Update previous level status
		end
	end

	// Combinational logic for next state
	always @(*) begin
		case (state)
			LOW_LEVEL: begin
				if (s == 3'b001) 
					next_state = MID_LEVEL;
				else if (s == 3'b011) 
					next_state = HIGH_LEVEL;
				else if (s == 3'b111) 
					next_state = ABOVE_HIGH_LEVEL;
				else 
					next_state = LOW_LEVEL;
			end
			MID_LEVEL: begin
				if (s == 3'b000) 
					next_state = LOW_LEVEL;
				else if (s == 3'b011) 
					next_state = HIGH_LEVEL;
				else if (s == 3'b111) 
					next_state = ABOVE_HIGH_LEVEL;
				else 
					next_state = MID_LEVEL;
			end
			HIGH_LEVEL: begin
				if (s == 3'b000) 
					next_state = LOW_LEVEL;
				else if (s == 3'b001) 
					next_state = MID_LEVEL;
				else if (s == 3'b111) 
					next_state = ABOVE_HIGH_LEVEL;
				else 
					next_state = HIGH_LEVEL;
			end
			ABOVE_HIGH_LEVEL: begin
				if (s == 3'b000) 
					next_state = LOW_LEVEL;
				else if (s == 3'b001) 
					next_state = MID_LEVEL;
				else if (s == 3'b011) 
					next_state = HIGH_LEVEL;
				else 
					next_state = ABOVE_HIGH_LEVEL;
			end
			default: next_state = LOW_LEVEL;
		endcase
	end

	// Combinational logic for output signals
	always @(*) begin
		// default values
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;

		case (state)
			LOW_LEVEL: begin
				fr3 = 1'b1;
				fr2 = 1'b1;
				fr1 = 1'b1;
				dfr = 1'b0;
			end
			MID_LEVEL: begin
				fr2 = 1'b1;
				fr1 = 1'b1;
				if (prev_level)
					dfr = 1'b1;
			end
			HIGH_LEVEL: begin
				fr1 = 1'b1;
				if (prev_level)
					dfr = 1'b1;
			end
			ABOVE_HIGH_LEVEL: begin
				// No flow rate inputs asserted
			end
		endcase
	end
	
endmodule
