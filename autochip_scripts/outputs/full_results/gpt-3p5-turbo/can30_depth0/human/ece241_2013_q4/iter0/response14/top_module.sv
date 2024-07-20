module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

// State machine states
parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;
parameter S3 = 3;

// State machine variables
reg [1:0] state;
reg [1:0] prev_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= S0;
		prev_state <= S0;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case (state)
			S0: begin
				if (s[3])
					state <= S0;
				else if (s[2])
					state <= S1;
				else if (s[1])
					state <= S2;
				else
					state <= S3;
			end

			S1: begin
				if (s[3])
					state <= S0;
				else if (s[2])
					state <= S1;
				else
					state <= S2;
			end

			S2: begin
				if (s[3])
					state <= S0;
				else if (s[2])
					state <= S1;
				else if (s[1])
					state <= S2;
				else
					state <= S3;
			end

			S3: begin
				if (s[3])
					state <= S0;
				else if (s[2])
					state <= S1;
				else if (s[1])
					state <= S2;
				else
					state <= S3;
			end
		endcase
	end
end

always @(state or prev_state) begin
	case (state)
		S0: begin
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end

		S1: begin
			fr3 <= 1'b0;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end

		S2: begin
			fr3 <= 1'b0;
			fr2 <= 1'b0;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end

		S3: begin
			fr3 <= 1'b0;
			fr2 <= 1'b0;
			fr1 <= 1'b0;
			if (prev_state == S2)
				dfr <= 1'b1;
			else
				dfr <= 1'b0;
		end
	endcase
end

assign prev_state = state;

endmodule
