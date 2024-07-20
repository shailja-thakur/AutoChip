module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic ff_output;

always_ff @(posedge clk) begin
	ff_output <= xor_output;
end

assign xor_output = in ^ out;
assign out = ff_output;

endmodule
