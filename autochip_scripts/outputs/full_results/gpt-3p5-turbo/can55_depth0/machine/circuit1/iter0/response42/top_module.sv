module top_module (
  input a,
  input b,
  output reg q
);

  always @(a, b) begin
    q = a & b;
  end

endmodule
