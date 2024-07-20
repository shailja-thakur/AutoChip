module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

always @(posedge clk or posedge areset) begin
	if (areset)
		q <= 4'b0000;
	else if (load)
		q <= data;
	else if (ena)
		q <= {q[2:0], 1'b0};
end

endmodule
