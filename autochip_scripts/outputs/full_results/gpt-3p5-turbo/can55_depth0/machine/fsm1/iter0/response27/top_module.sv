module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b1;
	else if (state == 2'b0)
		state <= (in) ? state : 2'b1;
	else
		state <= (in) ? 2'b1 : state;
end

assign out = (state == 2'b1) ? 1'b1 : 1'b0;

endmodule
