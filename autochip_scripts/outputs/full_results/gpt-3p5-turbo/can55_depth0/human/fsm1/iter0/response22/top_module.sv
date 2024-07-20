module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= B;
	else
		state <= next_state;
end

always @(state or in) begin
	case (state)
		A:
			if (in)
				next_state <= A;
			else
				next_state <= B;

		B:
			if (in)
				next_state <= B;
			else
				next_state <= A;
	endcase
end

assign out = (state == A) ? 1'b1 : 1'b0;

endmodule
