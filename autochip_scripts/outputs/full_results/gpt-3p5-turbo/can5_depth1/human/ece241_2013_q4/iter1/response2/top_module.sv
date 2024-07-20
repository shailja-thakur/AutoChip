module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output [1:0] fr,
	output reg dfr
);

wire [3:1] last_s;
reg [1:0] state;

parameter ABOVE_S3 = 2'b00;
parameter BETWEEN_S3_S2 = 2'b01;
parameter BETWEEN_S2_S1 = 2'b10;
parameter BELOW_S1 = 2'b11;

assign fr[0] = fr1;
assign fr[1] = fr2;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= ABOVE_S3;
		fr1 <= 1'b1;
		fr2 <= 1'b1;
		fr3 <= 1'b1;
		dfr <= 1'b1;
		last_s <= 3'b0;
	end else begin
		last_s <= s;

		case (state)
			ABOVE_S3:
				if (s[3]) begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
					state <= ABOVE_S3;
				end else if (s[2]) begin
					fr1 <= 1'b1;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
					state <= BETWEEN_S3_S2;
				end else if (s[1]) begin
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b1;
					state <= BETWEEN_S2_S1;
				end else begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b1;
					state <= BELOW_S1;
				end

			BETWEEN_S3_S2:
				if (s[3]) begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
					state <= ABOVE_S3;
				end else if (s[2]) begin
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b0;
					state <= BETWEEN_S3_S2;
				end else if (s[1]) begin
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b1;
					state <= BETWEEN_S2_S1;
				end else begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b1;
					state <= BELOW_S1;
				end

			BETWEEN_S2_S1:
				if (s[3]) begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
					state <= ABOVE_S3;
				end else if (s[2]) begin
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b0;
					state <= BETWEEN_S3_S2;
				end else if (s[1]) begin
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b1;
					state <= BETWEEN_S2_S1;
				end else begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b1;
					state <= BELOW_S1;
				end

			BELOW_S1:
				if (s[3]) begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
					state <= ABOVE_S3;
				end else if (s[2]) begin
					fr1 <= 1'b1;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
					state <= BETWEEN_S3_S2;
				end else if (s[1]) begin
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b0;
					dfr <= 1'b1;
					state <= BETWEEN_S2_S1;
				end else begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b1;
					state <= BELOW_S1;
				end
		endcase
	end
end

endmodule
