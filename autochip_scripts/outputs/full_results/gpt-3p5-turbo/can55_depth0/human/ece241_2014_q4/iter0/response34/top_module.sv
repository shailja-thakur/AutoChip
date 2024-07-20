module top_module (
  input clk,
  input x,
  output z
);

  reg a;
  reg b;
  reg c;

  always @(posedge clk) begin
    a <= x ^ a;
    b <= ~a & b;
    c <= ~a | c;
  end

  assign z = ~(a ^ b ^ c);

endmodule
