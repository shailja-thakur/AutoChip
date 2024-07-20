module top_module (
	input clk,
	input d,
	input ar,
	output reg q
);

always @(posedge clk or negedge ar) begin
	if (!ar)
		q <= 1'b0;
	else
		q <= d;
end

endmodule
