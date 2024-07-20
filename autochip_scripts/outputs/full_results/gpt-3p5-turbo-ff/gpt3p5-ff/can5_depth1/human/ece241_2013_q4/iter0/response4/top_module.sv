module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [1:0] state;
reg [1:0] prev_state;

parameter ABOVE_S3 = 2'b00; // Water level above s[3]
parameter BETWEEN_S3_S2 = 2'b01; // Water level between s[3] and s[2]
parameter BETWEEN_S2_S1 = 2'b10; // Water level between s[2] and s[1]
parameter BELOW_S1 = 2'b11; // Water level below s[1]

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= ABOVE_S3;
		prev_state <= ABOVE_S3;
		fr1 <= 0;
		fr2 <= 0;
		fr3 <= 0;
		dfr <= 0;
	end else begin
		prev_state <= state;
		case (state)
			ABOVE_S3: begin
				if (s[1] && s[2] && s[3]) begin
					state <= ABOVE_S3;
					fr1 <= 0;
					fr2 <= 0;
					fr3 <= 0;
					dfr <= 0;
				end else if (s[1] && s[2] && !s[3]) begin
					state <= BETWEEN_S3_S2;
					fr1 <= 1;
					fr2 <= 0;
					fr3 <= 0;
					dfr <= 0;
				end
			end
			BETWEEN_S3_S2: begin
				if (s[1] && s[2] && !s[3]) begin
					state <= BETWEEN_S3_S2;
					fr1 <= 1;
					fr2 <= 0;
					fr3 <= 0;
					dfr <= 0;
				end else if (s[1] && !s[2] && !s[3]) begin
					state <= BETWEEN_S2_S1;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 0;
					dfr <= 0;
				end
			end
			BETWEEN_S2_S1: begin
				if (s[1] && !s[2] && !s[3]) begin
					state <= BETWEEN_S2_S1;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 0;
					if (prev_state == ABOVE_S3) begin
						dfr <= 1;
					end else begin
						dfr <= 0;
					end
				end else if (!s[1]) begin
					state <= BELOW_S1;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 1;
					if (prev_state == ABOVE_S3 || prev_state == BETWEEN_S3_S2) begin
						dfr <= 1;
					end else begin
						dfr <= 0;
					end
				end
			end
			BELOW_S1: begin
				if (!s[1]) begin
					state <= BELOW_S1;
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 1;
					if (prev_state == ABOVE_S3 || prev_state == BETWEEN_S3_S2) begin
						dfr <= 1;
					end else begin
						dfr <= 0;
					end
				end
			end
		endcase
	end
end

endmodule
