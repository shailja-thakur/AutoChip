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
parameter IDLE = 2'b00;
parameter HIGH_LEVEL = 2'b01;
parameter MIDDLE_LEVEL = 2'b10;
parameter LOW_LEVEL = 2'b11;
parameter MAX_FLOW = 2'b10;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b0;
	end else begin
		case (state)
			IDLE: begin
				if (s[3]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= HIGH_LEVEL;
				end else if (s[2]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= MIDDLE_LEVEL;
				end else if (s[1]) begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= MIDDLE_LEVEL;
				end else begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					state <= LOW_LEVEL;
				end
			end
			HIGH_LEVEL: begin
				if (!s[3]) begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					state <= IDLE;
				end
			end
			MIDDLE_LEVEL: begin
				if (s[3]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= HIGH_LEVEL;
				end else if (s[2]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= MIDDLE_LEVEL;
				end else if (s[1]) begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b0;
					dfr <= 1'b1;
					state <= MIDDLE_LEVEL;
				end else begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					state <= LOW_LEVEL;
				end
			end
			LOW_LEVEL: begin
				if (s[3]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= HIGH_LEVEL;
				end else if (s[2]) begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					state <= MIDDLE_LEVEL;
				end else if (!s[1]) begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					state <= IDLE;
				end
			end
		endcase
	end
end

endmodule
