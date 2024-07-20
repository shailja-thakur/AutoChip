module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:1] s_prev;
reg [3:1] s_next;

parameter ABOVE_S3_STATE = 3'b000;
parameter BETWEEN_S3_AND_S2_STATE = 3'b001;
parameter BETWEEN_S2_AND_S1_STATE = 3'b010;
parameter BELOW_S1_STATE = 3'b011;

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= ABOVE_S3_STATE;
		s_prev <= 3'b000;
	end else begin
		state <= next_state;
		s_prev <= s;
	end
end

always @(*) begin
	next_state = state;
	case (state)
		ABOVE_S3_STATE: begin
			if (s[3])
				next_state = BETWEEN_S3_AND_S2_STATE;
		end
		BETWEEN_S3_AND_S2_STATE: begin
			if (!s[3])
				next_state = ABOVE_S3_STATE;
			else if (s[2])
				next_state = BETWEEN_S2_AND_S1_STATE;
		end
		BETWEEN_S2_AND_S1_STATE: begin
			if (!s[2])
				next_state = BETWEEN_S3_AND_S2_STATE;
			else if (s[1])
				next_state = BELOW_S1_STATE;
		end
		BELOW_S1_STATE: begin
			if (s[1])
				next_state = BETWEEN_S2_AND_S1_STATE;
		end
	endcase
end

always @(posedge clk) begin
	case (state)
		ABOVE_S3_STATE: begin
			fr3 <= 0;
			fr2 <= 0;
			fr1 <= 0;
			dfr <= 0;
		end
		BETWEEN_S3_AND_S2_STATE: begin
			fr3 <= 0;
			fr2 <= 0;
			fr1 <= 1;
			dfr <= 0;
		end
		BETWEEN_S2_AND_S1_STATE: begin
			fr3 <= 0;
			fr2 <= 1;
			fr1 <= 1;
			dfr <= 0;
		end
		BELOW_S1_STATE: begin
			fr3 <= 1;
			fr2 <= 1;
			fr1 <= 1;
			if (s[1] < s_prev)
				dfr <= 1;
			else
				dfr <= 0;
		end
	endcase
end

endmodule
