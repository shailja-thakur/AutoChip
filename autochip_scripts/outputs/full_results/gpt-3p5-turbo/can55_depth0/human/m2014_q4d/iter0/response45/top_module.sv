module top_module (
	input clk,
	input in,
	output logic out
);

logic d;

xor #(2) xor_gate(
  .a(in),
  .b(out),
  .o(d)
);

always_ff @(posedge clk) begin
  out <= d;
end

endmodule
