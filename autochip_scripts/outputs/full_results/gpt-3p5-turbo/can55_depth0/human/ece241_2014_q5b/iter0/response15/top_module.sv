module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg a, b;

always @(posedge clk or posedge areset) begin
	if (areset)
		a <= 1'b1;
	else if (x)
		a <= 1'b0;
	else if (!x)
		a <= a;
end

always @(posedge clk or posedge areset) begin
	if (areset)
		b <= 1'b0;
	else if (a && x)
		b <= 1'b1;
	else if (a && !x)
		b <= b;
end

assign z = b;

endmodule
