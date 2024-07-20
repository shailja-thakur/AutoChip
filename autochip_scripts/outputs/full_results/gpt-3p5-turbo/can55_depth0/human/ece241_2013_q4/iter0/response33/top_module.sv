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
reg prev_s;

// State machine states
parameter IDLE = 2'b00;
parameter ABOVE = 2'b01;
parameter BETWEEN_3_2 = 2'b10;
parameter BETWEEN_2_1 = 2'b11;

// Reset state
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		fr3 <= 1'b1;
		fr2 <= 1'b1;
		fr1 <= 1'b1;
		dfr <= 1'b0;
		prev_s <= s;
	end else begin
		case (state)
			IDLE: begin
				if (s[3]) begin
					state <= ABOVE;
				end else if (s[2]) begin
					state <= BETWEEN_3_2;
					fr1 <= 1'b1;
				end else if (s[1]) begin
					state <= BETWEEN_2_1;
					fr1 <= 1'b1;
					fr2 <= 1'b1;
				end else begin
					fr1 <= 1'b1;
					fr2 <= 1'b1;
					fr3 <= 1'b1;
				end
				prev_s <= s;
			end
			ABOVE: begin
				if (!s[3]) begin
					state <= IDLE;
				end
				prev_s <= s;
			end
			BETWEEN_3_2: begin
				if (s[1]) begin
					state <= BETWEEN_2_1;
					fr1 <= 1'b1;
				end else if (!s[2]) begin
					state <= IDLE;
				end
				prev_s <= s;
			end
			BETWEEN_2_1: begin
				if (!s[1]) begin
					state <= IDLE;
				end else if (prev_s[2] < s[2]) begin
					dfr <= 1'b1;
				end
				prev_s <= s;
			end
		endcase
	end
end

endmodule
