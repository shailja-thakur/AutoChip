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
	if (reset)
		state <= A;
	else begin
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
			 S20: state <= B;
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
		endcase
	end
end

always @(state) begin
	case (state)
		S22: z <= 1'b1;
		default: z <= 1'b0;
	endcase
end

endmodule
