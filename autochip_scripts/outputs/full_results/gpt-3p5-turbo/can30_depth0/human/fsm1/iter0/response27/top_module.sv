module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;

parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= B;
	else
		state <= next_state;
end

always @(*)
begin
	case (state)
		B:
		begin
			if (in)
				next_state = A;
			else
				next_state = B;
			out = 1;
		end

		A:
		begin
			if (in)
				next_state = A;
			else
				next_state = B;
			out = 0;
		end
	endcase
end

endmodule
