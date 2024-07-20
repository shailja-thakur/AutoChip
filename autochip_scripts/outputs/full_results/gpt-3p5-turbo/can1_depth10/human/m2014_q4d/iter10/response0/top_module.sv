module top_module (
    input wire clk,
    input wire in,
    output wire out
);

  reg xor_output;
  reg flip_flop_output;

  always @(posedge clk)
  begin
      flip_flop_output <= xor_output;
      xor_output <= in ^ flip_flop_output;
  end

  assign out = flip_flop_output;

endmodule
