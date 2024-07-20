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

parameter ABOVE_S3 = 2'b00;
parameter BETWEEN_S3_S2 = 2'b01;
parameter BETWEEN_S2_S1 = 2'b10;
parameter BELOW_S1 = 2'b11;

always @(posedge clk) begin
	if (reset == 1'b1) begin
		state <= BELOW_S1;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case(state)
			ABOVE_S3: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
				dfr <= 1'b0;
				
				if (s[3] == 1'b0) begin
					state <= BETWEEN_S3_S2;
				end
			end
			
			BETWEEN_S3_S2: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				
				if (s[2] == 1'b0) begin
					state <= BETWEEN_S2_S1;
				end
				if (s[3] == 1'b1) begin
					state <= ABOVE_S3;
				end
			end
			
			BETWEEN_S2_S1: begin
				fr3 <= 1'b0;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				
				if (s[1] == 1'b0) begin
					state <= BELOW_S1;
				end
				if (s[2] == 1'b1) begin
					state <= BETWEEN_S3_S2;
				end
			end
			
			BELOW_S1: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				
				if (s[1] == 1'b1) begin
					state <= BETWEEN_S2_S1;
				end
			end
		endcase
	end
end

endmodule
