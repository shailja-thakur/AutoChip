module top_module (
	input clk,
	input d,
	input ar,
	output reg q
);

always @(posedge clk or negedge ar) begin
	if (!ar)
		q <= 0;
	else if (ar && (ar === 1'b1))
		q <= d;
	else
		q <= q;
end

endmodule
