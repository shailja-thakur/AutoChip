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
	localparam [1:0]
		LOW = 2'b00,
		MED_LOW = 2'b01,
		MED_HIGH = 2'b10,
		HIGH = 2'b11;
	
	reg [1:0] state, next_state;
	reg prev_lower;

	// State transition logic
	always @(*) begin
		case (state)
			LOW: begin
				if (s[3])
					next_state = HIGH;
				else if (s[2])
					next_state = MED_HIGH;
				else if (s[1])
					next_state = MED_LOW;
				else
					next_state = LOW;
			end
			MED_LOW: begin
				if (s[3])
					next_state = HIGH;
				else if (s[2])
					next_state = MED_HIGH;
				else if (!s[1])
					next_state = LOW;
				else
					next_state = MED_LOW;
			end
			MED_HIGH: begin
				if (s[3])
					next_state = HIGH;
				else if (!s[2])
					next_state = MED_LOW;
				else if (!s[1])
					next_state = LOW;
				else
					next_state = MED_HIGH;
			end
			HIGH: begin
				if (!s[3])
					next_state = MED_HIGH;
				else
					next_state = HIGH;
			end
			default: next_state = LOW;
		endcase
	end

	// Output logic
	always @(*) begin
		// Default outputs
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;
		case(state)
			LOW: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
				dfr = 1;
			end
			MED_LOW: begin
				fr2 = 1;
				fr1 = 1;
				if (prev_lower)
					dfr = 1;
			end
			MED_HIGH: begin
				fr1 = 1;
				if (prev_lower)
					dfr = 1;
			end
			HIGH: begin
				// All outputs stay at 0
			end
		endcase
	end

	// State register and prev_lower update
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW;
			prev_lower <= 0;
		end
		else begin
			if (state != next_state)
				prev_lower <= (state < next_state);
			state <= next_state;
		end
	end

endmodule
