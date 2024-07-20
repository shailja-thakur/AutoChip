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

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

always @(posedge clk) begin
	if (reset) begin
		state <= S0;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case (state)
			S0: begin
				if (s == 3'b111) begin
					state <= S0;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end else if (s == 3'b011) begin
					state <= S1;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end else if (s == 3'b001) begin
					state <= S2;
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end else if (s == 3'b000) begin
					state <= S3;
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
			end
			S1: begin
				if (s == 3'b111) begin
					state <= S0;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end else if (s == 3'b011) begin
					state <= S1;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end else if (s == 3'b001) begin
					state <= S2;
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end else if (s == 3'b000) begin
					state <= S3;
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
			end
			S2: begin
				if (s == 3'b111) begin
					state <= S0;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end else if (s == 3'b011) begin
					state <= S1;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end else if (s == 3'b001) begin
					state <= S2;
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end else if (s == 3'b000) begin
					state <= S3;
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
			end
			S3: begin
				if (s == 3'b111) begin
					state <= S0;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end else if (s == 3'b011) begin
					state <= S1;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end else if (s == 3'b001) begin
					state <= S2;
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end else if (s == 3'b000) begin
					state <= S3;
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
			end
		endcase
	end
end

endmodule
