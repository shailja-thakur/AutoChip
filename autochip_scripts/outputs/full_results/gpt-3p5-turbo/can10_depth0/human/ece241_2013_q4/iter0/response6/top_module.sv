module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [2:0] state;
reg [2:0] next_state;

parameter IDLE_STATE = 3'b000;
parameter ABOVE_S3_STATE = 3'b001;
parameter BETWEEN_S3_S2_STATE = 3'b010;
parameter BETWEEN_S2_S1_STATE = 3'b011;
parameter BELOW_S1_STATE = 3'b100;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE_STATE;
	end else begin
		state <= next_state;
	end
end

always @(state or s) begin
	case (state)
		IDLE_STATE: begin
			if (s[3]) begin
				next_state <= ABOVE_S3_STATE;
			end else if (s[2]) begin
				next_state <= BETWEEN_S3_S2_STATE;
			end else if (s[1]) begin
				next_state <= BETWEEN_S2_S1_STATE;
			end else begin
				next_state <= BELOW_S1_STATE;
			end
		end

		ABOVE_S3_STATE: begin
			if (s[2] || s[1]) begin
				next_state <= BETWEEN_S3_S2_STATE;
			end else if (!s[3]) begin
				next_state <= IDLE_STATE;
			end
		end

		BETWEEN_S3_S2_STATE: begin
			if (s[1]) begin
				next_state <= BETWEEN_S2_S1_STATE;
			end else if (!s[3] && !s[2]) begin
				next_state <= IDLE_STATE;
			end
		end

		BETWEEN_S2_S1_STATE: begin
			if (!s[1]) begin
				next_state <= BELOW_S1_STATE;
			end else if (!s[3] && !s[2]) begin
				next_state <= IDLE_STATE;
			end
		end

		BELOW_S1_STATE: begin
			if (!s[1]) begin
				next_state <= IDLE_STATE;
			end
		end
	endcase
end

always @(state or s) begin
	fr3 <= 0;
	fr2 <= 0;
	fr1 <= 0;
	dfr <= 0;

	case (state)
		IDLE_STATE: begin
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
		end

		ABOVE_S3_STATE: begin
			// No outputs asserted
		end

		BETWEEN_S3_S2_STATE: begin
			fr1 <= 1;
		end

		BETWEEN_S2_S1_STATE: begin
			fr1 <= 1;
			fr2 <= 1;
		end

		BELOW_S1_STATE: begin
			fr1 <= 1;
			fr2 <= 1;
			fr3 <= 1;
		end
	endcase

	if (state != IDLE_STATE && s[3]) begin
		fr3 <= 0;
	end

	if (state == BETWEEN_S3_S2_STATE && !s[2]) begin
		fr2 <= 0;
	end

	if (state == BETWEEN_S2_S1_STATE && !s[1]) begin
		fr2 <= 0;
	end

	if (state == BELOW_S1_STATE && !s[1]) begin
		fr1 <= 0;
	end

	if (state == BETWEEN_S2_S1_STATE && s[1] && !s[3] && !s[2]) begin
		dfr <= 1;
	end
end

endmodule
