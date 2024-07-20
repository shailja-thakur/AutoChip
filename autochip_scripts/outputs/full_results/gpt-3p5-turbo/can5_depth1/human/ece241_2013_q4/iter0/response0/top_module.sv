module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:1] last_s;
reg [1:0] state;

parameter ABOVE_S3 = 2'b00;
parameter BETWEEN_S3_S2 = 2'b01;
parameter BETWEEN_S2_S1 = 2'b10;
parameter BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= ABOVE_S3;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
		last_s <= 3'b0;
	end else begin
		last_s <= s;

		case (state)
			ABOVE_S3:
				if (s[3]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= ABOVE_S3;
				end else if (s[2]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					state <= BETWEEN_S3_S2;
				end else if (s[1]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					state <= BETWEEN_S2_S1;
				end else begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					state <= BELOW_S1;
				end

			BETWEEN_S3_S2:
				if (s[3]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= ABOVE_S3;
				end else if (s[2]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					state <= BETWEEN_S3_S2;
				end else if (s[1]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					state <= BETWEEN_S2_S1;
				end else begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					state <= BELOW_S1;
				end

			BETWEEN_S2_S1:
				if (s[3]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= ABOVE_S3;
				end else if (s[2]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					state <= BETWEEN_S3_S2;
				end else if (s[1]) begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					state <= BETWEEN_S2_S1;
				end else begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					state <= BELOW_S1;
				end

			BELOW_S1:
				if (s[3]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= ABOVE_S3;
				end else if (s[2]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					state <= BETWEEN_S3_S2;
				end else if (s[1]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					state <= BETWEEN_S2_S1;
				end else begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					state <= BELOW_S1;
				end
		endcase
	end
end

endmodule
