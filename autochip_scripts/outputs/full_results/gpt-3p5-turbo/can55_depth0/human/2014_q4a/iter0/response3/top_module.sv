module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D;
wire load;
wire enable;
wire reset;

assign load = L & ~E;
assign enable = E & ~L;
assign reset = R & ~L;

always @(posedge clk or negedge reset) begin
	if (~reset)
		D <= 1'b0;
	else if (load)
		D <= R;
	else if (enable)
		D <= w;
end

always @(posedge clk) begin
	if (load)
		Q <= D;
	else
		Q <= D;
end

endmodule
