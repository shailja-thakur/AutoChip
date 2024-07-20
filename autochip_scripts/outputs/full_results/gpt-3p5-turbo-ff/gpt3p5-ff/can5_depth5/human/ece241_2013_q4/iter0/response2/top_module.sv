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
reg [1:0] prev_state;
reg [1:0] water_level;

// State machine transitions
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00; // Reset state
		water_level <= 2'b00; // Reset water level
	end else begin
		prev_state <= state;
		case (state)
			2'b00:
				if (s[3]) begin
					state <= 2'b00;
				end else if (s[2]) begin
					state <= 2'b01;
					water_level <= 2'b10;
				end else if (s[1]) begin
					state <= 2'b10;
					water_level <= 2'b01;
				end else begin
					state <= 2'b11;
					water_level <= 2'b00;
				end
			2'b01:
				if (s[3]) begin
					state <= 2'b00;
				end else if (s[2]) begin
					state <= 2'b01;
				end else begin
					state <= 2'b10;
				end
			2'b10:
				if (s[3]) begin
					state <= 2'b00;
				end else begin
					state <= 2'b01;
				end
			2'b11:
				if (s[3]) begin
					state <= 2'b00;
				end else if (s[2]) begin
					state <= 2'b01;
				end else if (s[1]) begin
					state <= 2'b10;
				end else begin
					state <= 2'b11;
				end
		endcase
	end
end

// Output assignment
always @(*) begin
	case (state)
		2'b00:
			fr1 = 0;
			fr2 = 0;
			fr3 = 0;
			dfr = 0;
		2'b01:
			fr1 = 1;
			fr2 = 0;
			fr3 = 0;
			dfr = 0;
		2'b10:
			fr1 = 1;
			fr2 = 1;
			fr3 = 0;
			if (water_level > prev_state) begin
				dfr = 1;
			end else begin
				dfr = 0;
			end
		2'b11:
			fr1 = 1;
			fr2 = 1;
			fr3 = 1;
			if (water_level > prev_state) begin
				dfr = 1;
			end else begin
				dfr = 0;
			end
	endcase
end

endmodule
