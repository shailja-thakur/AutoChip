module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state;

always @*
begin
	case (state)
		A: begin
			if (j)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (k)
				next_state = A;
			else
				next_state = B;
		end
	endcase
end

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= A;
	else
		state <= next_state;
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
