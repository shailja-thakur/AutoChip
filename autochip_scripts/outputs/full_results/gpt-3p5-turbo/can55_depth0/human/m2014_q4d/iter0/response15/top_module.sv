module top_module (
	input clk,
	input in,
	output logic out
);

logic ff_out;
logic xor_out;

always @(posedge clk) begin
    xor_out = in ^ out;
    ff_out = xor_out;
    out <= ff_out;
end

endmodule
