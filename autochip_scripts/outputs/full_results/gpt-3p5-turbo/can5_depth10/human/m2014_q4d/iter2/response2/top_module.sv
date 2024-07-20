module top_module (
	input clk,
	input in,
	output logic out
);

reg d;
always @(posedge clk)
begin
	d <= in ^ out;
end

always @(posedge clk)
begin
	out <= d;
end

assign out = 1'b0;

endmodule
