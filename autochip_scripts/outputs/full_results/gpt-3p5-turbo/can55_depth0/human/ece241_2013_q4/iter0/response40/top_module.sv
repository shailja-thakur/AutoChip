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

parameter s_above_s3 = 3'b000;
parameter s_between_s3_s2 = 3'b001;
parameter s_between_s2_s1 = 3'b010;
parameter s_below_s1 = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= s_below_s1;
	end else begin
		case (state)
			s_above_s3: begin
				if (s == 3'b111) begin
					fr1 <= 0;
					fr2 <= 0;
					fr3 <= 0;
					dfr <= 0;
				end else if (s == 3'b110) begin
					fr1 <= 1;
					fr2 <= 0;
					fr3 <= 0;
					dfr <= 0;
					state <= s_between_s3_s2;
				end else if (s == 3'b100) begin
					fr1 <= 1;
					fr2 <= 0;
					fr3 <= 0;
					dfr <= 0;
					state <= s_between_s2_s1;
				end else if (s == 3'b000) begin
					fr1 <= 1;
					fr2 <= 0;
					fr3 <= 0;
					dfr <= 0;
					state <= s_below_s1;
				end
			end
			s_between_s3_s2: begin
				if (s == 3'b110) begin
					fr1 <= 1;
					fr2 <= 0;
					fr3 <= 0;
					dfr <= 0;
				end else if (s == 3'b100) begin
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 0;
					dfr <= 0;
					state <= s_between_s2_s1;
				end else if (s == 3'b000) begin
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 0;
					dfr <= 1;
					state <= s_below_s1;
				end
			end
			s_between_s2_s1: begin
				if (s == 3'b100) begin
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 0;
					dfr <= 1;
				end else if (s == 3'b000) begin
					fr1 <= 1;
					fr2 <= 1;
					fr3 <= 1;
					dfr <= 1;
					state <= s_below_s1;
				end
			end
			s_below_s1: begin
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 1;
				dfr <= 1;
			end
			default: begin
				state <= s_below_s1;
			end
		endcase
	end
end

endmodule
