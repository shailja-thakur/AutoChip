module top_module (
	input clk,
	input in,
	output logic out
);

always_ff @(posedge clk) begin
	out <= in ^ out;
end

initial begin
	out = 0;
end

endmodule
