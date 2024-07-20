module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Declare states
parameter A = 1'b0;
parameter B = 1'b1;
parameter C = 1'b0;
parameter S10 = 1'b0;
parameter S11 = 1'b0;
parameter S20 = 1'b0;
parameter S21 = 1'b0;
parameter S22 = 1'b0;

// Declare state signal
reg [3:0] state;

always @(posedge clk or posedge reset)
begin
	if (reset)
		state <= A;
	else
		case (state)
			A: begin
				if (s)
					state <= B;
				else
					state <= A;
			end
			B: begin
				if (w)
					state <= S11;
				else
					state <= S10;
			end
			C: begin
				if (w)
					state <= S11;
				else
					state <= S10;
			end
			S10: begin
				if (w)
					state <= S21;
				else
					state <= S20;
			end
			S11: begin
				if (w)
					state <= S22;
				else
					state <= S21;
			end
			S20: begin
				state <= B;
			end
			S21: begin
				if (w)
					state <= C;
				else
					state <= B;
			end
			S22: begin
				if (w)
					state <= B;
				else
					state <= C;
			end
			default: state <= A;
		endcase
	end
end

always @(state)
begin
	case (state)
		A: z <= 1'b0;
		B: z <= 1'b0;
		C: z <= 1'b0;
		S10: z <= 1'b0;
		S11: z <= 1'b0;
		S20: z <= 1'b0;
		S21: z <= 1'b0;
		S22: z <= 1'b0;
	endcase
end

endmodule
