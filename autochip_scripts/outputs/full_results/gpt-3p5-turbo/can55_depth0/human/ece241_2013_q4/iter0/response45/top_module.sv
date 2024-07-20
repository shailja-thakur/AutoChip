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
parameter S0 = 4'b0000;
parameter S1 = 4'b0001;
parameter S2 = 4'b0010;
parameter S3 = 4'b0011;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= S0;
	else begin
		case (state)
			S0: begin
				if (s[3]) // Water level above s[3]
					state <= S0;
				else if (s[2]) // Water level between s[3] and s[2]
					state <= S1;
				else if (s[1]) // Water level between s[2] and s[1]
					state <= S2;
				else // Water level below s[1]
					state <= S3;
			end
			S1: begin
				if (s[1]) // Water level between s[3] and s[2]
					state <= S1;
				else if (s[2]) // Water level above s[2]
					state <= S2;
				else // Water level below s[1]
					state <= S3;
			end
			S2: begin
				if (s[1]) // Water level above s[1]
					state <= S2;
				else // Water level below s[1]
					state <= S3;
			end
			S3: begin
				if (s[3]) // Water level above s[3]
					state <= S0;
				else if (s[2]) // Water level between s[3] and s[2]
					state <= S1;
				else if (s[1]) // Water level between s[2] and s[1]
					state <= S2;
				else // Water level below s[1]
					state <= S3;
			end
			default: state <= S0;
		endcase
	end
end

always @(state) begin
	case (state)
		S0: begin
			fr1 <= 0;
			fr2 <= 0;
			fr3 <= 0;
			dfr <= 0;
		end
		S1: begin
			fr1 <= 1;
			fr2 <= 0;
			fr3 <= 0;
			dfr <= 0;
		end
		S2: begin
			fr1 <= 1;
			fr2 <= 1;
			fr3 <= 0;
			dfr <= 0;
		end
		S3: begin
			fr1 <= 1;
			fr2 <= 1;
			fr3 <= 1;
			dfr <= 1;
		end
		default: begin
			fr1 <= 0;
			fr2 <= 0;
			fr3 <= 0;
			dfr <= 0;
		end
	endcase
end

endmodule
