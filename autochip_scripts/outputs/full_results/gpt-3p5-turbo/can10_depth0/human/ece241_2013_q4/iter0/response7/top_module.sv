module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:1] prev_s;
reg [2:0] state;

// State machine states
parameter [2:0] STATE_ABOVE_S3 = 3'b000;
parameter [2:0] STATE_BETWEEN_S3_AND_S2 = 3'b001;
parameter [2:0] STATE_BETWEEN_S2_AND_S1 = 3'b010;
parameter [2:0] STATE_BELOW_S1 = 3'b011;

always @(posedge clk) begin
	if (reset) begin
		// Reset to initial state
		state <= STATE_BELOW_S1;
	end else begin
		// State transitions based on sensor inputs and current state
		case (state)
			STATE_ABOVE_S3: begin
				if (s[1] && s[2] && s[3]) begin
					// Water level is above s[3], no flow rate
					state <= STATE_ABOVE_S3;
				end else if (s[1] && s[2]) begin
					// Water level is between s[3] and s[2], fr1 flow rate
					state <= STATE_BETWEEN_S3_AND_S2;
				end else if (s[1]) begin
					// Water level is between s[2] and s[1], fr1 and fr2 flow rates
					state <= STATE_BETWEEN_S2_AND_S1;
				end else begin
					// Water level is below s[1], fr1, fr2, and fr3 flow rates
					state <= STATE_BELOW_S1;
				end
			end
			STATE_BETWEEN_S3_AND_S2: begin
				if (s[1] && s[2] && !s[3]) begin
					// Water level is between s[3] and s[2], fr1 flow rate
					state <= STATE_BETWEEN_S3_AND_S2;
				end else if (s[1] && !s[2]) begin
					// Water level is between s[2] and s[1], fr1 and fr2 flow rates
					state <= STATE_BETWEEN_S2_AND_S1;
				end else if (!s[1]) begin
					// Water level is below s[1], fr1, fr2, and fr3 flow rates
					state <= STATE_BELOW_S1;
				end else begin
					// Water level is above s[3], no flow rate
					state <= STATE_ABOVE_S3;
				end
			end
			STATE_BETWEEN_S2_AND_S1: begin
				if (s[1] && !s[2]) begin
					// Water level is between s[2] and s[1], fr1 and fr2 flow rates
					state <= STATE_BETWEEN_S2_AND_S1;
				end else if (!s[1]) begin
					// Water level is below s[1], fr1, fr2, and fr3 flow rates
					state <= STATE_BELOW_S1;
				end else if (s[1] && s[2]) begin
					// Water level is between s[3] and s[2], fr1 flow rate
					state <= STATE_BETWEEN_S3_AND_S2;
				end else begin
					// Water level is above s[3], no flow rate
					state <= STATE_ABOVE_S3;
				end
			end
			STATE_BELOW_S1: begin
				if (!s[1]) begin
					// Water level is below s[1], fr1, fr2, and fr3 flow rates
					state <= STATE_BELOW_S1;
				end else if (s[1] && s[2]) begin
					// Water level is between s[3] and s[2], fr1 flow rate
					state <= STATE_BETWEEN_S3_AND_S2;
				end else if (s[1] && !s[2]) begin
					// Water level is between s[2] and s[1], fr1 and fr2 flow rates
					state <= STATE_BETWEEN_S2_AND_S1;
				end else begin
					// Water level is above s[3], no flow rate
					state <= STATE_ABOVE_S3;
				end
			end
		endcase
	end
end

always @(posedge clk) begin
	// Output assignments based on current state
	case (state)
		STATE_ABOVE_S3: begin
			fr1 <= 0;
			fr2 <= 0;
			fr3 <= 0;
		end
		STATE_BETWEEN_S3_AND_S2: begin
			fr1 <= 1;
			fr2 <= 0;
			fr3 <= 0;
		end
		STATE_BETWEEN_S2_AND_S1: begin
			fr1 <= 1;
			fr2 <= 1;
			fr3 <= 0;
		end
		STATE_BELOW_S1: begin
			fr1 <= 1;
			fr2 <= 1;
			fr3 <= 1;
		end
	endcase
end

always @(posedge clk) begin
	// Output dfr based on previous and current sensor inputs
	if (reset) begin
		dfr <= 1'b0;
		prev_s <= 3'b000;
	end else begin
		if (s[1] < prev_s[1] || s[2] < prev_s[2] || s[3] < prev_s[3]) begin
			dfr <= 1'b1;
		end else begin
			dfr <= 1'b0;
		end
		prev_s <= s;
	end
end

endmodule
