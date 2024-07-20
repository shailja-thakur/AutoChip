module top_module (
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] s,
  output reg overflow
);

always @(a, b) begin
  s = a + b;

  if (s > 127 || s < -128)
    overflow = 1;
  else
    overflow = 0;
end

endmodule
