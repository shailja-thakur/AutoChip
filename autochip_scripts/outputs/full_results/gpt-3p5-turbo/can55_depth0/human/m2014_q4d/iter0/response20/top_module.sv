module top_module (
    input clk,
    input in,
    output logic out
);

  logic xor_output;
  logic d_input;
  always_comb begin
    xor_output = in ^ out;
    d_input = xor_output;
  end

  // D flip flop
  always_ff @(posedge clk) begin
    out <= d_input;
  end

endmodule
