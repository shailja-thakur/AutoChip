module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:0] state;
reg [1:0] prev_state;

parameter ABOVE_S3 = 4'b0001;
parameter BETWEEN_S3_S2 = 4'b0010;
parameter BETWEEN_S2_S1 = 4'b0100;
parameter BELOW_S1 = 4'b1000;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BELOW_S1;
		prev_state <= BELOW_S1;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end
	else begin
		case (state)
			ABOVE_S3: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
				dfr <= 1'b0;
				if (s[1] && s[2] && s[3])
					state <= ABOVE_S3;
				else if (s[1] && s[2] && !s[3])
					state <= BETWEEN_S3_S2;
				else if (s[1] && !s[2] && !s[3])
					state <= BETWEEN_S2_S1;
				else if (!s[1] && !s[2] && !s[3])
					state <= BELOW_S1;
				else
					state <= ABOVE_S3;
			end
			
			BETWEEN_S3_S2: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (s[1] && s[2] && s[3])
					state <= ABOVE_S3;
				else if (s[1] && s[2] && !s[3])
					state <= BETWEEN_S3_S2;
				else if (s[1] && !s[2] && !s[3])
					state <= BETWEEN_S2_S1;
				else if (!s[1] && !s[2] && !s[3])
					state <= BELOW_S1;
				else
					state <= BETWEEN_S3_S2;
			end
			
			BETWEEN_S2_S1: begin
				fr3 <= 1'b0;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (s[1] && s[2] && s[3])
					state <= ABOVE_S3;
				else if (s[1] && s[2] && !s[3])
					state <= BETWEEN_S3_S2;
				else if (s[1] && !s[2] && !s[3])
					state <= BETWEEN_S2_S1;
				else if (!s[1] && !s[2] && !s[3])
					state <= BELOW_S1;
				else
					state <= BETWEEN_S2_S1;
			end
			
			BELOW_S1: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (s[1] && s[2] && s[3])
					state <= ABOVE_S3;
				else if (s[1] && s[2] && !s[3])
					state <= BETWEEN_S3_S2;
				else if (s[1] && !s[2] && !s[3])
					state <= BETWEEN_S2_S1;
				else if (!s[1] && !s[2] && !s[3])
					state <= BELOW_S1;
				else
					state <= BELOW_S1;
			end
			
			default: begin
				state <= BELOW_S1;
				prev_state <= state;
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b1;
			end
		endcase
	end
end

always @(posedge clk) begin
	prev_state <= state;
end

endmodule
