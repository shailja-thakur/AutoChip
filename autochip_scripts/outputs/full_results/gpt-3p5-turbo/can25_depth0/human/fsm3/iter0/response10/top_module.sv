module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;
reg out;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or areset) begin
	if (areset) begin
		state <= A;
		out <= 0;
	end else begin
		state <= next_state;
		out <= (state == D) ? 1'b1 : 1'b0;
	end
end

always @(state, in) begin
	case(state)
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
	endcase
end

endmodule
