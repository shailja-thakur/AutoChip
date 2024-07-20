module top_module (
  input clk,
  input j,
  input k,
  output reg Q
);

always @(posedge clk)
begin
  if (j & ~Q)
    Q <= 1'b1;
  else if (~k & Q)
    Q <= 1'b0;
  else if (j & k)
    Q <= ~Q;
end

endmodule
