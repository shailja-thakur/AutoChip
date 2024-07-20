module top_module (
	input clk,
	input in,
	input reset,
	output out
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;
wire next_state;

always @(posedge clk) begin
	if (reset) begin
		state <= B;
	end else begin
		state <= next_state;
	end
end

assign next_state = (state == A && in) ? A :
                   (state == B && in) ? B :
                   (state == A && !in) ? B :
                   (state == B && !in) ? A : B;

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
