module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [1:0] prevState;
reg [1:0] currState;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		currState <= 2'b00;
	end else begin
		prevState <= currState;

		case (prevState)
			2'b00: begin // Below s[1]
				if (s[3]) begin
					currState <= 2'b01;
				end else if (s[2]) begin
					currState <= 2'b10;
				end else if (s[1]) begin
					currState <= 2'b11;
				end else begin
					currState <= 2'b00;
				end
			end

			2'b01: begin // Above s[3]
				if (s[3]) begin
					currState <= 2'b01;
				end else if (s[2]) begin
					currState <= 2'b10;
				end else if (s[1]) begin
					currState <= 2'b11;
				end else begin
					currState <= 2'b00;
				end
			end

			2'b10: begin // Between s[2] and s[1]
				if (s[3]) begin
					currState <= 2'b01;
				end else if (s[2]) begin
					currState <= 2'b10;
				end else if (s[1]) begin
					currState <= 2'b11;
				end else begin
					currState <= 2'b00;
				end
			end

			2'b11: begin // Between s[3] and s[2]
				if (s[3]) begin
					currState <= 2'b01;
				end else if (s[2]) begin
					currState <= 2'b10;
				end else if (s[1]) begin
					currState <= 2'b11;
				end else begin
					currState <= 2'b00;
				end
			end
		endcase
	end
end

always @(currState) begin
	case (currState)
		2'b00: begin // Below s[1]
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end

		2'b01: begin // Above s[3]
			fr3 <= 1'b0;
			fr2 <= 1'b0;
			fr1 <= 1'b0;
			dfr <= 1'b0;
		end

		2'b10: begin // Between s[2] and s[1]
			fr3 <= 1'b0;
			fr2 <= 1'b0;
			fr1 <= 1'b1;
			dfr <= 1'b0;
		end

		2'b11: begin // Between s[3] and s[2]
			fr3 <= 1'b0;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b1;
		end
	endcase
end

endmodule
