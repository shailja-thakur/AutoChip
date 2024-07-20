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

parameter ABOVE_S3 = 2'b00;
parameter BETWEEN_S3_S2 = 2'b01;
parameter BETWEEN_S2_S1 = 2'b10;
parameter BELOW_S1 = 2'b11;

always @(posedge clk) begin
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
				fr1 <= 0;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;

				if (s[3]) begin
					state <= BETWEEN_S3_S2;
				end
			end

			BETWEEN_S3_S2: begin
				fr1 <= 1;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;

				if (s[2]) begin
					state <= BETWEEN_S2_S1;
				end
			end

			BETWEEN_S2_S1: begin
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 0;
				dfr <= 0;

				if (s[1]) begin
					state <= BELOW_S1;
				end
			end

			BELOW_S1: begin
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 1;
				dfr <= 0;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (reset) begin
		dfr <= 0;
	end else begin
		if (prev_state < state) begin
			dfr <= 1;
		end else begin
			dfr <= 0;
		end
	end
end

endmodule
