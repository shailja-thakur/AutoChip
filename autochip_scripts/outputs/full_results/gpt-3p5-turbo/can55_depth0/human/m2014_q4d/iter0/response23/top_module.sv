module top_module (
  input clk,
  input in,
  output logic out
);

  logic xor_output;
  logic flipflop_input;

  xor2 #(2) XOR1 (
    .a(in),
    .b(out),
    .o(xor_output)
  );

  always @(posedge clk) begin
    flipflop_input <= xor_output;
  end

  always @(posedge clk) begin
    out <= flipflop_input;
  end

endmodule
