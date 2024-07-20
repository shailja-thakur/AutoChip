module top_module (
	input clk,
	input in,
	input reset,
	output out
);

parameter A = 0;
parameter B = 1;

reg [1:0] state;
wire nextState;

assign out = (state == B) ? 1'b1 : 1'b0;

always @(posedge clk) begin
	if (reset) begin
		state <= B;
	end else begin
		state <= nextState;
	end
end

assign nextState = (state == A && in) ? B : (state == B && in) ? A : state;

endmodule
