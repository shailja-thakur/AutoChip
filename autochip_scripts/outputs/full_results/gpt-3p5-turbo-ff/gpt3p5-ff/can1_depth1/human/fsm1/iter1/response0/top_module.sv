module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;
parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= B;
	else
		state <= next_state;
	end
end

assign out = (state == A) ? 1'b1 : 1'b0;

always @(state, in) begin
	case (state)
		B: begin
			if (in) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		A: begin
			if (in) begin
				next_state = A;
			end else begin
				next_state = B;
			end
		end
	endcase
end

endmodule
