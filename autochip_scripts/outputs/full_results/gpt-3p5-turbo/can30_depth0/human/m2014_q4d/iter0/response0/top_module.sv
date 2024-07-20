module top_module (
	input clk,
	input in,
	output logic out
);

reg d = 0;

always @(posedge clk) begin
	d <= in ^ out;
	out <= d;
end

endmodule
