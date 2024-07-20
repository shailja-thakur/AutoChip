module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg prev_level;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
		prev_level <= 0;
	end else begin
		case(s)
			3'b100: begin // Above s[3]
				fr3 <= 1'b0;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b1;
			end
			3'b011: begin // Between s[3] and s[2]
				fr3 <= 1'b0;
				fr2 <= 1'b1;
				fr1 <= 1'b0;
				dfr <= 1'b1;
			end
			3'b010: begin // Between s[2] and s[1]
				fr3 <= 1'b1;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
				dfr <= 1'b1;
			end
			3'b001: begin // Below s[1]
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
				dfr <= 1'b1;
			end
			default: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b1;
			end
		endcase
		
		if (prev_level < s[2:1])
			dfr <= 1'b1;
		else
			dfr <= 1'b0;
			
		prev_level <= s[2:1];
	end
end

endmodule
