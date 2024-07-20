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

parameter [1:0] ABOVE_S3 = 2'b00;
parameter [1:0] BETWEEN_S3_AND_S2 = 2'b01;
parameter [1:0] BETWEEN_S2_AND_S1 = 2'b10;
parameter [1:0] BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		state <= ABOVE_S3;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case (state)
			ABOVE_S3: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
				dfr <= 1'b0;
				if (s == 3'b011)
					state <= BETWEEN_S3_AND_S2;
			end
			BETWEEN_S3_AND_S2: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (s == 3'b010)
					state <= BETWEEN_S2_AND_S1;
				else if (s == 3'b100)
					state <= ABOVE_S3;
			end
			BETWEEN_S2_AND_S1: begin
				fr3 <= 1'b0;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (s == 3'b001)
					state <= BELOW_S1;
				else if (s == 3'b100)
					state <= ABOVE_S3;
			end
			BELOW_S1: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (s == 3'b000)
					state <= BELOW_S1;
				else if (s == 3'b100)
					state <= ABOVE_S3;
			end
		endcase
	end
end

endmodule
