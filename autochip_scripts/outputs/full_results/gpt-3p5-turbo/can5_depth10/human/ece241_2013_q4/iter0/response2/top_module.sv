module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [2:0] water_level;
reg [2:0] prev_level;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		water_level <= 3'b000;
		prev_level <= 3'b000;
	end else begin
		case (s)
			3'b111: begin // Above s[3]
				water_level <= 3'b111;
				prev_level <= s;
				fr1 <= 0;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;
			end
			3'b110: begin // Between s[3] and s[2]
				water_level <= 3'b110;
				prev_level <= s;
				fr1 <= 1;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;
			end
			3'b100: begin // Between s[2] and s[1]
				water_level <= 3'b100;
				prev_level <= s;
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 0;
				dfr <= 0;
			end
			3'b000: begin // Below s[1]
				water_level <= 3'b000;
				prev_level <= s;
				fr1 <= 1;
				fr2 <= 1;
				fr3 <= 1;
				dfr <= 0;
			end
			default: begin
				// Invalid state, handle error condition
				water_level <= 3'b000;
				prev_level <= 3'b000;
				fr1 <= 0;
				fr2 <= 0;
				fr3 <= 0;
				dfr <= 0;
			end
		endcase
	end
end

endmodule
