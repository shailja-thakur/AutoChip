module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

// State declaration
reg [2:0] state_reg, state_next;

// Constants declaration
parameter STATE_LOW = 3'b000;
parameter STATE_HIGH = 3'b001;
parameter STATE_BETWEEN_2_AND_3 = 3'b010;
parameter STATE_BETWEEN_1_AND_2 = 3'b011;

// Register declaration
reg fr3_reg, fr2_reg, fr1_reg, dfr_reg;
reg fr3_next, fr2_next, fr1_next, dfr_next;

// Initial assignment
initial begin
	state_reg = STATE_LOW;
	fr3_reg = 1'b0;
	fr2_reg = 1'b0;
	fr1_reg = 1'b0;
	dfr_reg = 1'b0;
end

// State logic
always @(posedge clk) begin
	if (reset) begin
		state_reg <= STATE_LOW;
		fr3_reg <= 1'b1;
		fr2_reg <= 1'b1;
		fr1_reg <= 1'b1;
		dfr_reg <= 1'b1;
	end else begin
		state_reg <= state_next;
		fr3_reg <= fr3_next;
		fr2_reg <= fr2_next;
		fr1_reg <= fr1_next;
		dfr_reg <= dfr_next;
	end
end

// Next state logic
always @* begin
	case (state_reg)
		STATE_LOW:
			if (s[3]) begin
				state_next = STATE_HIGH;
				fr3_next = 1'b0;
				fr2_next = 1'b0;
				fr1_next = 1'b0;
				dfr_next = 1'b0;
			end else if (s[2]) begin
				state_next = STATE_BETWEEN_2_AND_3;
				fr3_next = 1'b0;
				fr2_next = 1'b0;
				fr1_next = 1'b0;
				dfr_next = 1'b0;
			end else if (s[1]) begin
				state_next = STATE_BETWEEN_1_AND_2;
				fr3_next = 1'b0;
				fr2_next = 1'b0;
				fr1_next = 1'b0;
				dfr_next = 1'b0;
			end
		STATE_HIGH:
			if (!s[3]) begin
				state_next = STATE_BETWEEN_2_AND_3;
				fr3_next = 1'b0;
				fr2_next = 1'b0;
				fr1_next = 1'b1;
				dfr_next = 1'b0;
			end else if (s[2]) begin
				state_next = STATE_BETWEEN_2_AND_3;
				fr3_next = 1'b0;
				fr2_next = 1'b0;
				fr1_next = 1'b0;
				dfr_next = 1'b0;
			end else if (s[1]) begin
				state_next = STATE_BETWEEN_1_AND_2;
				fr3_next = 1'b0;
				fr2_next = 1'b0;
				fr1_next = 1'b0;
				dfr_next = 1'b0;
			end
		STATE_BETWEEN_2_AND_3:
			if (!s[3]) begin
				state_next = STATE_BETWEEN_1_AND_2;
				fr3_next = 1'b0;
				fr2_next = 1'b0;
				fr1_next = 1'b1;
				dfr_next = 1'b0;
			end else if (!s[2]) begin
				state_next = STATE_LOW;
				fr3_next = 1'b1;
				fr2_next = 1'b1;
				fr1_next = 1'b1;
				dfr_next = 1'b1;
			end
		STATE_BETWEEN_1_AND_2:
			if (!s[2]) begin
				state_next = STATE_LOW;
				fr3_next = 1'b1;
				fr2_next = 1'b1;
				fr1_next = 1'b1;
				dfr_next = 1'b1;
			end else if (!s[1]) begin
				state_next = STATE_LOW;
				fr3_next = 1'b1;
				fr2_next = 1'b1;
				fr1_next = 1'b1;
				dfr_next = 1'b1;
			end
	endcase
end

// Output assignment
always @(posedge clk) begin
	fr3 <= fr3_reg;
	fr2 <= fr2_reg;
	fr1 <= fr1_reg;
	dfr <= dfr_reg;
end

endmodule
