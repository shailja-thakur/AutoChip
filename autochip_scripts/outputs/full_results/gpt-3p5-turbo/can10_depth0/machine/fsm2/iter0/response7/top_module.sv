module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state;
reg [1:0] next_state;

always @(*) begin
	case(state)
		A: next_state = (j) ? B : A;
		B: next_state = (k) ? A : B;
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
