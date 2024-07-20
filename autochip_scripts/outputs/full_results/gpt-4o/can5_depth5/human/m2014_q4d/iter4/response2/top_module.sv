module top_module (
	input clk,
	input in,
	output logic out
);

logic d;

always_ff @(posedge clk) begin
	d <= in ^ out;
end

assign out = d;

endmodule
