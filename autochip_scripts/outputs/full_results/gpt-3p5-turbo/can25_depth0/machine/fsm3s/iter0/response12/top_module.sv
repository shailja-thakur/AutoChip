module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case (state)
		A: begin
			if (in)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (in)
				next_state = B;
			else
				next_state = C;
		end
		C: begin
			if (in)
				next_state = D;
			else
				next_state = A;
		end
		D: begin
			if (in)
				next_state = B;
			else
				next_state = C;
		end
		default: next_state = A;
	endcase
end

always @(posedge clk) begin
	if (state == D)
		out <= 1;
	else
		out <= 0;
end

endmodule
