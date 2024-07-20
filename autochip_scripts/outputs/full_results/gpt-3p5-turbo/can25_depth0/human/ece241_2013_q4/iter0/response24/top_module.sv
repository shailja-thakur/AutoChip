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

parameter ABOVE = 2'b00;
parameter BETWEEN32 = 2'b01;
parameter BETWEEN21 = 2'b10;
parameter BELOW = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BELOW;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
	end else begin
		case(state)
			ABOVE: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
				dfr <= 1'b0;
				if (s[3])
					state <= BETWEEN32;
			end
			BETWEEN32: begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (!s[3] && s[2])
					state <= BETWEEN21;
				else if (s[1])
					state <= BELOW;
			end
			BETWEEN21: begin
				fr3 <= 1'b0;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b0;
				if (!s[3] && s[1])
					state <= BELOW;
				else if (!s[2])
					state <= BETWEEN32;
			end
			BELOW: begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
				dfr <= 1'b1;
				if (s[1])
					state <= BETWEEN21;
				else if (s[2])
					state <= BETWEEN32;
			end
		endcase
	end
end

endmodule
