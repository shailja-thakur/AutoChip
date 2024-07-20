module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

reg [1:0] state, next_state;

always @(state or j or k) begin
	case(state)
		A: begin
			if(j)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if(k)
				next_state = A;
			else
				next_state = B;
		end
		default: next_state = A;
	endcase
end

always @(posedge clk) begin
	if(areset)
		state <= A;
	else
		state <= next_state;
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
