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
reg fr1_next, fr2_next, fr3_next, dfr_next;

always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
		state <= 3'b001;
		fr1 <= 1'b1;
		fr2 <= 1'b1;
		fr3 <= 1'b1;
		dfr <= 1'b1;
	end
	else
	begin
		case (state)
			3'b001: // Above s[3]
				begin
					if (s[3])
						state <= 3'b010; // Between s[3] and s[2]
				end
			3'b010: // Between s[3] and s[2]
				begin
					if (!s[3])
						state <= 3'b001; // Above s[3]
					else if (s[2])
						state <= 3'b011; // Between s[2] and s[1]
				end
			3'b011: // Between s[2] and s[1]
				begin
					if (!s[2])
						state <= 3'b010; // Between s[3] and s[2]
					else if (s[1])
						state <= 3'b100; // Below s[1]
				end
			3'b100: // Below s[1]
				begin
					if (!s[1])
						state <= 3'b011; // Between s[2] and s[1]
				end
			default:
				state <= 3'b001; // Above s[3]
		endcase
	end
end

always @*
begin
	dfr_next = 1'b0;
	fr1_next = 1'b0;
	fr2_next = 1'b0;
	fr3_next = 1'b0;

	case (state)
		3'b001: // Above s[3]
			begin
				dfr_next = 1'b0;
				fr1_next = 1'b0;
				fr2_next = 1'b0;
				fr3_next = 1'b0;
			end
		3'b010: // Between s[3] and s[2]
			begin
				dfr_next = 1'b0;
				fr1_next = 1'b1;
				fr2_next = 1'b0;
				fr3_next = 1'b0;
			end
		3'b011: // Between s[2] and s[1]
			begin
				dfr_next = 1'b0;
				fr1_next = 1'b1;
				fr2_next = 1'b1;
				fr3_next = 1'b0;
			end
		3'b100: // Below s[1]
			begin
				dfr_next = 1'b1;
				fr1_next = 1'b1;
				fr2_next = 1'b1;
				fr3_next = 1'b1;
			end
		default:
			begin
				dfr_next = 1'b0;
				fr1_next = 1'b0;
				fr2_next = 1'b0;
				fr3_next = 1'b0;
			end
	endcase
end

always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
		dfr <= dfr_next;
		fr1 <= fr1_next;
		fr2 <= fr2_next;
		fr3 <= fr3_next;
	end
	else
	begin
		dfr <= dfr_next;
		fr1 <= fr1_next;
		fr2 <= fr2_next;
		fr3 <= fr3_next;
	end
end

endmodule
