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

parameter ABOVE_S3 = 0;
parameter BETWEEN_S3_S2 = 1;
parameter BETWEEN_S2_S1 = 2;
parameter BELOW_S1 = 3;

always @(posedge clk) begin
	
	if (reset) begin
		state <= BELOW_S1;
		fr3 <= 1;
		fr2 <= 1;
		fr1 <= 1;
		dfr <= 0;
	end
	
	else begin
	
		case(state)
			
			ABOVE_S3: begin
				if (s[3] == 1'b1) begin
					fr3 <= 0;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
					state <= ABOVE_S3;
				end
				else if (s[2] == 1'b1) begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 0;
					dfr <= 0;
					state <= BETWEEN_S3_S2;
				end
				else if (s[1] == 1'b1) begin
					fr3 <= 1;
					fr2 <= 0;
					fr1 <= 0;
					dfr <= 1;
					state <= BETWEEN_S2_S1;
				end
				else begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
					state <= BELOW_S1;
				end
			end
			
			BETWEEN_S3_S2: begin
				if (s[3] == 1'b1) begin
					fr3 <= 0;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
					state <= ABOVE_S3;
				end
				else if (s[2] == 1'b1) begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 0;
					dfr <= 0;
					state <= BETWEEN_S3_S2;
				end
				else if (s[1] == 1'b1) begin
					fr3 <= 1;
					fr2 <= 0;
					fr1 <= 0;
					dfr <= 1;
					state <= BETWEEN_S2_S1;
				end
				else begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
					state <= BELOW_S1;
				end
			end
			
			BETWEEN_S2_S1: begin
				if (s[3] == 1'b1) begin
					fr3 <= 0;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
					state <= ABOVE_S3;
				end
				else if (s[2] == 1'b1) begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 0;
					dfr <= 0;
					state <= BETWEEN_S3_S2;
				end
				else if (s[1] == 1'b1) begin
					fr3 <= 1;
					fr2 <= 0;
					fr1 <= 0;
					dfr <= 1;
					state <= BETWEEN_S2_S1;
				end
				else begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
					state <= BELOW_S1;
				end
			end
			
			BELOW_S1: begin
				if (s[3] == 1'b1) begin
					fr3 <= 0;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
					state <= ABOVE_S3;
				end
				else if (s[2] == 1'b1) begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 0;
					dfr <= 0;
					state <= BETWEEN_S3_S2;
				end
				else if (s[1] == 1'b1) begin
					fr3 <= 1;
					fr2 <= 0;
					fr1 <= 0;
					dfr <= 1;
					state <= BETWEEN_S2_S1;
				end
				else begin
					fr3 <= 1;
					fr2 <= 1;
					fr1 <= 1;
					dfr <= 0;
					state <= BELOW_S1;
				end
			end
			
		endcase
	
	end
end

endmodule
