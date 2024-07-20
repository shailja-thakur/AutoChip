module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

// Define states
parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;
parameter S3 = 3;

reg [1:0] state;
reg [1:0] prev_level;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= S0;
		prev_level <= 0;
	end else begin
		case (state)
			S0: begin
				if (s == 3'b111) begin
					state <= S0;
				end else if (s == 3'b011) begin
					state <= S1;
				end else if (s == 3'b001) begin
					state <= S2;
				end else if (s == 3'b000) begin
					state <= S3;
				end
			end
			S1: begin
				if (s == 3'b111) begin
					state <= S0;
				end else if (s == 3'b110) begin
					state <= S1;
				end else if (s == 3'b100) begin
					state <= S2;
				end else if (s == 3'b000) begin
					state <= S3;
				end
			end
			S2: begin
				if (s == 3'b111) begin
					state <= S0;
				end else if (s == 3'b010) begin
					state <= S1;
				end else if (s == 3'b000) begin
					state <= S2;
				end else if (s == 3'b000) begin
					state <= S3;
				end
			end
			S3: begin
				if (s == 3'b011) begin
					state <= S0;
				end else if (s == 3'b001) begin
					state <= S1;
				end else if (s == 3'b000) begin
					state <= S2;
				end else if (s == 3'b000) begin
					state <= S3;
				end
			end
		endcase
	end
end

always @(posedge clk) begin
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
			dfr <= prev_level < s;
		end
		S2: begin
			fr1 <= 1;
			fr2 <= 1;
			fr3 <= 0;
			dfr <= prev_level < s;
		end
		S3: begin
			fr1 <= 1;
			fr2 <= 1;
			fr3 <= 1;
			dfr <= prev_level < s;
		end
	endcase
	prev_level <= s;
end

endmodule
