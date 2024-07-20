module top_module (
	input clk,
	input d,
	input ar,
	output reg q
);

reg q_next;

always @(posedge clk or negedge ar) begin
	if (!ar)
		q_next <= 1'b0;
	else if (ar && (ar === 1'b1))
		q_next <= d;
	else
		q_next <= q;
end

always @(posedge clk) begin
	if (!ar)
		q <= 0;
	else
		q <= q_next;
end

endmodule
