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
	
	state_t state, next_state;
	reg previous_state_was_lower;

	// State transition logic
	always @(*) begin
		case (state)
			LOW: begin
				if (s[1]) begin
					if (s[2]) begin
						if (s[3]) begin
							next_state = HIGH;
						} else begin
							next_state = MID_HIGH;
						end
					end else begin
						next_state = MID_LOW;
					end
				end else begin
					next_state = LOW;
				end
			end
			MID_LOW: begin
				if (s[1]) begin
					if (s[2]) begin
						if (s[3]) begin
							next_state = HIGH;
						} else begin
							next_state = MID_HIGH;
						end
					end else begin
						next_state = MID_LOW;
					end
				end else begin
					next_state = LOW;
				end
			end
			MID_HIGH: begin
				if (s[1]) begin
					if (s[2]) begin
						if (s[3]) begin
							next_state = HIGH;
						end else begin
							next_state = MID_HIGH;
						end
					end else begin
						next_state = MID_LOW;
					end
				end else begin
					next_state = LOW;
				end
			end
			HIGH: begin
				if (s[1]) begin
					if (s[2]) begin
						if (s[3]) begin
							next_state = HIGH;
						end else begin
							next_state = MID_HIGH;
						end
					end else begin
						next_state = MID_LOW;
					end
				end else begin
					next_state = LOW;
				end
			end
			default: next_state = LOW;
		endcase
	end

	// State register
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW;
			previous_state_was_lower <= 1'b0;
		end else begin
			previous_state_was_lower <= (next_state > state);
			state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		// Default values
		fr1 = 1'b0;
		fr2 = 1'b0;
		fr3 = 1'b0;
		dfr = 1'b0;

		case (state)
			LOW: begin
				fr1 = 1'b1;
				fr2 = 1'b1;
				fr3 = 1'b1;
			end
			MID_LOW: begin
				fr1 = 1'b1;
				fr2 = 1'b1;
				if (previous_state_was_lower) begin
					dfr = 1'b1;
				end
			end
			MID_HIGH: begin
				fr1 = 1'b1;
				if (previous_state_was_lower) begin
					dfr = 1'b1;
				end
			end
			HIGH: begin
				// No flow
			end
		endcase
	end
	
endmodule
