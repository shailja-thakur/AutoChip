module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @(state, in) begin
	case (state)
		A: begin
			if (in)
				next_state = B;
			else
				next_state = A;
			out <= 0;
		end
		B: begin
			if (in)
				next_state = B;
			else
				next_state = C;
			out <= 0;
		end
		C: begin
			if (in)
				next_state = D;
			else
				next_state = A;
			out <= 0;
		end
		D: begin
			if (in)
				next_state = B;
			else
				next_state = C;
			out <= 1;
		end
	endcase
end

endmodule
