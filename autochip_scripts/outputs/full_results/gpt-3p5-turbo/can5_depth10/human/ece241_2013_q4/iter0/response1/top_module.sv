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

	always @(posedge clk or posedge reset)
	begin
		if (reset)
		begin
			fr3 <= 1'b1;
			fr2 <= 1'b1;
			fr1 <= 1'b1;
			dfr <= 1'b0;
			state <= 2'b00;
			prev_state <= 2'b00;
		end
		else
		begin
			prev_state <= state;
			case (state)
				2'b00: // Above s[3]
				begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b0;
					dfr <= 1'b0;
					if (s == 3'b111)
						state <= 2'b00;
					else if (s == 3'b110)
						state <= 2'b01;
					else if (s == 3'b100)
						state <= 2'b10;
					else if (s == 3'b000)
						state <= 2'b11;
				end
				2'b01: // Between s[3] and s[2]
				begin
					fr3 <= 1'b0;
					fr2 <= 1'b0;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					if (s == 3'b110)
						state <= 2'b01;
					else if (s == 3'b100)
						state <= 2'b10;
					else if (s == 3'b000)
						state <= 2'b11;
					else if (s == 3'b111)
						state <= 2'b00;
				end
				2'b10: // Between s[2] and s[1]
				begin
					fr3 <= 1'b0;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b0;
					if (s == 3'b100)
						state <= 2'b10;
					else if (s == 3'b000)
						state <= 2'b11;
					else if (s == 3'b111)
						state <= 2'b00;
					else if (s == 3'b110)
						state <= 2'b01;
				end
				2'b11: // Below s[1]
				begin
					fr3 <= 1'b1;
					fr2 <= 1'b1;
					fr1 <= 1'b1;
					dfr <= 1'b1;
					if (s == 3'b000)
						state <= 2'b11;
					else if (s == 3'b111)
						state <= 2'b00;
					else if (s == 3'b110)
						state <= 2'b01;
					else if (s == 3'b100)
						state <= 2'b10;
				end
			endcase
		end
	end

endmodule
