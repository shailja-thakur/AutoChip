module top_module (
  input clk,
  input in,
  output logic out
);

  logic xor_out;
  logic d_ff_in;

  // XOR gate
  assign xor_out = in ^ out;

  // D flip-flop
  always_ff @(posedge clk) begin
    d_ff_in <= xor_out;
    out <= d_ff_in;
  end

endmodule
