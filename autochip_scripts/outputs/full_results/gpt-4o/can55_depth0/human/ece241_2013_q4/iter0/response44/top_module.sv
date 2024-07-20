module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

	// Define states
	typedef enum reg [1:0] {
		LOW,
		BETWEEN_S1_S2,
		BETWEEN_S2_S3,
		ABOVE_S3
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= LOW;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic and output logic
	always @(*) begin
		// Default values
		fr3 = 1'b0;
		fr2 = 1'b0;
		fr1 = 1'b0;
		dfr = 1'b0;

		case(state)
			LOW: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
				if (s[1]) begin
					next_state = BETWEEN_S2_S1;
				end else begin
					next_state = LOW;
				end
			end
			BETWEEN_S1_S2: begin
				fr3 = 0;
				fr2 = 1;
				fr1 = 1;
				if (s[2]) begin
					dfr = 1;
					next_state = BETWEEN_S2_S3;
				end else if (!s[1]) begin
					dfr = 1;
					next_state = LOW;
				end else begin
					next_state = BETWEEN_S1_S2;
				end
			end
			BETWEEN_S2_S3: begin
				fr3 = 0;
				fr2 = 0;
				fr1 = 1;
				if (s[3]) begin
					dfr = 1;
					next_state = ABOVE_S3;
				end else if (!s[2]) begin
					dfr = 1;
					next_state = BETWEEN_S1_S2;
				end else begin
					next_state = BETWEEN_S2_S3;
				end
			end
			ABOVE_S3: begin
				fr3 = 0;
				fr2 = 0;
				fr1 = 0;
				if (!s[3]) begin
					dfr = 1;
					next_state = BETWEEN_S2_S3;
				end else begin
					next_state = ABOVE_S3;
				end
			end
			default: begin
				fr3 = 0;
				fr2 = 0;
				fr1 = 0;
				dfr = 0;
				next_state = LOW;
			end
		endcase
	end

endmodule
