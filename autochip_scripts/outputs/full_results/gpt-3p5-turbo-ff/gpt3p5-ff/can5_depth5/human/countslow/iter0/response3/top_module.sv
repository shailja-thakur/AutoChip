module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
	if (reset)
		q <= 0;
	else if (slowena)
		q <= q + 1;
end

endmodule
