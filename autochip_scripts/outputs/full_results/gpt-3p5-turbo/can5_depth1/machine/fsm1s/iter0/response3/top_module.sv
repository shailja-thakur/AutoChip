module top_module (
	input wire clk,
	input wire in,
	input wire reset,
	output wire out
);

parameter stateA = 0;
parameter stateB = 1;

reg [1:0] state;
always @(posedge clk) begin
	if (reset)
		state <= stateB;
	else if (state == stateA)
		state <= (in) ? stateA : stateB;
	else if (state == stateB)
		state <= (in) ? stateB : stateA;
end

assign out = (state == stateB) ? 1'b1 : 1'b0;

endmodule
