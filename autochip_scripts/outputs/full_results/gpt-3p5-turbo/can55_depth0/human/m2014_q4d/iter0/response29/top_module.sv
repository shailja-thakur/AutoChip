module top_module (
	input clk,
	input in,
	output logic out
);

reg d = 0;
wire xor_output;

assign xor_output = in ^ out;

always @(posedge clk) begin
	d <= xor_output;
	out <= d;
end

endmodule
