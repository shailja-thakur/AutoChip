module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state;
parameter A = 0, B = 1, C = 2, S10 = 3, S11 = 4, S20 = 5, S21 = 6, S22 = 7;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		case (state)
			A: if (s) state <= B;
			B: if (w) state <= S11; else state <= S10;
			C: if (w) state <= S11; else state <= S10;
			S10: if (w) state <= S21; else state <= S20;
			S11: if (w) state <= S22; else state <= S21;
			S20: state <= B;
			S21: if (w) state <= C; else state <= B;
			S22: if (w) state <= B; else state <= C;
			default: state <= A;
		endcase
	end
end

always @(state) begin
	case (state)
		A: z <= 0;
		B, C, S10, S11, S20, S21, S22: z <= 1;
		default: z <= 0;
	endcase
end

endmodule
