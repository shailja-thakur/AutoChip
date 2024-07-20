module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 0;
parameter B = 1;

reg state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		A: begin
			if (x) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		B: begin
			next_state = B;
		end
	endcase
end

assign z = (state == A && x) || (state == B && ~x);

endmodule
