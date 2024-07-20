module top_module (
	input clk,
	input in,
	output logic out
);

reg d;
reg d_next;

always @(posedge clk)
begin
	d <= d_next;
end

always @(posedge clk)
begin
	d_next <= in ^ out;
end

always @(posedge clk)
begin
	out <= d;
end

endmodule
