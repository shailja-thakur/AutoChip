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
reg [2:0] prev_state;

// State machine states
parameter ABOVE_S3 = 3'b000;
parameter BETWEEN_S3_S2 = 3'b001;
parameter BETWEEN_S2_S1 = 3'b010;
parameter BELOW_S1 = 3'b011;

// Reset state
always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
		state <= BELOW_S1;
		prev_state <= BELOW_S1;
	end
	else
	begin
		prev_state <= state;
		case (state)
			ABOVE_S3:
				if (s[3] == 1'b0)
					state <= BETWEEN_S3_S2;
			BETWEEN_S3_S2:
				if (s[3] == 1'b1)
					state <= ABOVE_S3;
				else if (s[2] == 1'b0)
					state <= BETWEEN_S2_S1;
			BETWEEN_S2_S1:
				if (s[3] == 1'b1)
					state <= ABOVE_S3;
				else if (s[2] == 1'b1)
					state <= BETWEEN_S3_S2;
				else if (s[1] == 1'b0)
					state <= BELOW_S1;
			BELOW_S1:
				if (s[3] == 1'b1)
					state <= ABOVE_S3;
				else if (s[1] == 1'b1)
					state <= BETWEEN_S2_S1;
		endcase
	end
end

// Output control
always @(state or prev_state)
begin
	case (state)
		ABOVE_S3:
			begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b0;
			end
		BETWEEN_S3_S2:
			begin
				fr3 <= 1'b0;
				fr2 <= 1'b0;
				fr1 <= 1'b1;
			end
		BETWEEN_S2_S1:
			begin
				fr3 <= 1'b0;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
			end
		BELOW_S1:
			begin
				fr3 <= 1'b1;
				fr2 <= 1'b1;
				fr1 <= 1'b1;
			end
	endcase
	if (state != prev_state)
	begin
		dfr <= (prev_state > state) ? 1'b1 : 1'b0;
	end
end

endmodule
