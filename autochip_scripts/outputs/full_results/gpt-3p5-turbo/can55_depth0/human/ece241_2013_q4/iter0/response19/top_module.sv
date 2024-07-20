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

parameter ABOVE_S3_STATE = 2'b00;
parameter BTWN_S3_S2_STATE = 2'b01;
parameter BTWN_S2_S1_STATE = 2'b10;
parameter BELOW_S1_STATE = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BELOW_S1_STATE;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case (state)
			ABOVE_S3_STATE:
				begin
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
					if(s == 3'b011) begin
						state <= BTWN_S3_S2_STATE;
					end
				end
			BTWN_S3_S2_STATE:
				begin
					dfr <= 1'b0;
					if(s == 3'b001) begin
						state <= BTWN_S2_S1_STATE;
					end else if(s == 3'b011) begin
						state <= ABOVE_S3_STATE;
					end
				end
			BTWN_S2_S1_STATE:
				begin
					dfr <= 1'b0;
					if(s == 3'b001) begin
						state <= BTWN_S2_S1_STATE;
					end else begin
						state <= BELOW_S1_STATE;
					end
				end
			BELOW_S1_STATE:
				begin
					fr3 <= 1'b1;
					if(s == 3'b000) begin
						state <= BELOW_S1_STATE;
					end else begin
						fr2 <= 1'b0;
						fr1 <= 1'b0;
						if(s == 3'b001) begin
							dfr <= 1'b1;
						end
						state <= BTWN_S2_S1_STATE;
					end
				end
		endcase
	end
end

endmodule
