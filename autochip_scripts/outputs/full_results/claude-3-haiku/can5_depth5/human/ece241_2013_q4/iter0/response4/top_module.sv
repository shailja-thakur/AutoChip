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
parameter LEVEL_ABOVE_S3 = 2'b00,
          LEVEL_BETWEEN_S3_S2 = 2'b01,
          LEVEL_BETWEEN_S2_S1 = 2'b10,
          LEVEL_BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= LEVEL_BELOW_S1;
		fr3 <= 1;
		fr2 <= 1;
		fr1 <= 1;
		dfr <= 1;
	end
	else begin
		case (state)
			LEVEL_ABOVE_S3: begin
				fr3 <= 0;
				fr2 <= 0;
				fr1 <= 0;
				dfr <= 0;
			end
			LEVEL_BETWEEN_S3_S2: begin
				fr3 <= 0;
				fr2 <= 1;
				fr1 <= 1;
				dfr <= 0;
			end
			LEVEL_BETWEEN_S2_S1: begin
				fr3 <= 0;
				fr2 <= 1;
				fr1 <= 1;
				dfr <= 1;
			end
			LEVEL_BELOW_S1: begin
				fr3 <= 1;
				fr2 <= 1;
				fr1 <= 1;
				dfr <= 1;
			end
			default: begin
				fr3 <= 1;
				fr2 <= 1;
				fr1 <= 1;
				dfr <= 1;
			end
		endcase

		if (s[3]) begin
			state <= LEVEL_ABOVE_S3;
		end
		else if (s[2]) begin
			state <= LEVEL_BETWEEN_S3_S2;
		end
		else if (s[1]) begin
			state <= LEVEL_BETWEEN_S2_S1;
		end
		else begin
			state <= LEVEL_BELOW_S1;
		end
	end
end

endmodule
