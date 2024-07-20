module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, next_state;

parameter A = 4'b0001;
parameter B = 4'b0010;
parameter C = 4'b0011;
parameter S10 = 4'b0100;
parameter S11 = 4'b0101;
parameter S20 = 4'b0110;
parameter S21 = 4'b0111;
parameter S22 = 4'b1000;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @(*) begin
	case (state)
		A: begin
			if (s)
				next_state = B;
		end
		B, C: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		S10: begin
			if (w)
				next_state = S21;
			else
				next_state = S20;
		end
		S11: begin
			if (w)
				next_state = S22;
			else
				next_state = S21;
		end
		S20: next_state = B;
		S21: begin
			if (w)
				next_state = C;
			else
				next_state = B;
		end
		S22: begin
			if (w)
				next_state = B;
			else
				next_state = C;
		end
	endcase
end

always @(posedge clk or posedge reset) begin
	if (reset)
		z <= 0;
	else begin
		case (state)
			A: z <= 0;
			S20, S22: z <= 1;
			default: z <= z;
		endcase
	end
end

endmodule
