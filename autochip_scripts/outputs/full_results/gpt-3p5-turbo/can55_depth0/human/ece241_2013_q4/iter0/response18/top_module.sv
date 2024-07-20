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
		state <= 3'b000;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case (state)
			3'b000: begin // Above s[3]
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
				dfr <= 1'b0;
				if (s[1] && s[2] && s[3])
					state <= 3'b000;
				else if (s[1] && s[2])
					state <= 3'b001;
				else if (s[1])
					state <= 3'b010;
				else
					state <= 3'b011;
			end
			3'b001: begin // Between s[3] and s[2]
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (s[1] && s[2])
					state <= 3'b001;
				else if (s[1])
					state <= 3'b010;
				else
					state <= 3'b011;
			end
			3'b010: begin // Between s[2] and s[1]
				fr3 <= 1'b0;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (s[1])
					state <= 3'b010;
				else
					state <= 3'b011;
			end
			3'b011: begin // Below s[1]
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (!s[1])
					state <= 3'b011;
				else
					state <= 3'b000;
			end
		endcase
	end
end

endmodule
