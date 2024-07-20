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

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case(state)
			0: begin
				if (s[3]) begin
					state <= 1;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end
			end
			1: begin
				if (s[1]) begin
					state <= 2;
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
				end
				else if (s[2]) begin
					state <= 3;
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end
			end
			2: begin
				if (!s[1]) begin
					state <= 1;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end
			end
			3: begin
				if (!s[2]) begin
					state <= 1;
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
				end
			end
		endcase
	end
end

endmodule
