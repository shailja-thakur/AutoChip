module top_module (
	input clk,
	input in,
	output logic out
);

logic d;

always @(posedge clk) begin
	d <= in ^ out;
end

always @(posedge clk) begin
	out <= d;
end

endmodule
