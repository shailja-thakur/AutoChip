module top_module (
	input clk,
	input in,
	output logic out
);

logic d;
logic xor_output;

always_ff @(posedge clk)
begin
	xor_output = in ^ out;
	d <= xor_output;
	out <= d;
end

endmodule
