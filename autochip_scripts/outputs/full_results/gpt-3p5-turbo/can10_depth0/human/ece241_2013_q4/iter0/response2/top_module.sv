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

parameter ABOVE_S3 = 3'b000;
parameter BETWEEN_S3_S2 = 3'b001;
parameter BETWEEN_S2_S1 = 3'b010;
parameter BELOW_S1 = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= ABOVE_S3;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case (state)
			ABOVE_S3:
				begin
					if (s[3] && !s[2] && !s[1]) begin
						state <= BETWEEN_S3_S2;
						fr3 <= 1'b0;
						fr2 <= 1'b1;
						fr1 <= 1'b0;
						dfr <= 1'b0;
					end
				end
			
			BETWEEN_S3_S2:
				begin
					if (s[3] && s[2] && !s[1]) begin
						state <= BETWEEN_S2_S1;
						fr3 <= 1'b0;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end else if (s[1] && !s[3]) begin
						state <= BELOW_S1;
						fr3 <= 1'b1;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end
				end
			
			BETWEEN_S2_S1:
				begin
					if (s[1] && !s[2] && !s[3]) begin
						state <= BELOW_S1;
						fr3 <= 1'b1;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b0;
					end
				end
			
			BELOW_S1:
				begin
					if (!s[1] && !s[2] && !s[3]) begin
						state <= ABOVE_S3;
						fr3 <= 1'b1;
						fr2 <= 1'b1;
						fr1 <= 1'b1;
						dfr <= 1'b1;
					end
				end
		endcase
	end
end

endmodule
