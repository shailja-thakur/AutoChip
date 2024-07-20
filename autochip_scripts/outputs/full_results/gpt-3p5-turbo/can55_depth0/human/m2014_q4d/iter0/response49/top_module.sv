module top_module (
	input clk,
	input in,
	output logic out
);

logic d;
logic xor_out;

DFF flip_flop (
  .clk(clk),
  .d(xor_out),
  .q(out)
);

XOR2 xor_gate (
  .a(in),
  .b(out),
  .y(xor_out)
);

endmodule
module DFF (
  input clk,
  input d,
  output reg q
);

always @(posedge clk) begin
  q <= d;
end

endmodule
module XOR2 (
  input a,
  input b,
  output y
);

assign y = a ^ b;

endmodule
