module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [3:1] prev_s;
reg [1:0] state;

// State machine states
parameter low_level = 2'b00;
parameter between_2_1 = 2'b01;
parameter between_3_2 = 2'b10;
parameter high_level = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b1;
		state <= low_level;
	end else begin
		prev_s <= s;
		case (state)
			low_level:
				if (s != 3'b111) begin
					state <= between_3_2;
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
				end
			between_3_2:
				if (s == 3'b111) begin
					state <= high_level;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b1;
				end else if (s == 3'b011) begin
					state <= between_2_1;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b1;
				end
			between_2_1:
				if (s == 3'b111) begin
					state <= high_level;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b1;
				end else if (s == 3'b001) begin
					state <= low_level;
					fr1 <= 1'b1;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b1;
				end
			high_level:
				if (s != 3'b111) begin
					state <= between_3_2;
					fr1 <= 1'b0;
					fr2 <= 1'b0;
					fr3 <= 1'b0;
					dfr <= 1'b0;
				end
		endcase
	end
end

endmodule
