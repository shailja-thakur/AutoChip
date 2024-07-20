module top_module (
  input clk,
  input a,
  output reg q
);

always @(posedge clk) begin
  if (a == 1'b0)
    q <= 1'b1;
  else if (a == 1'b1)
    q <= 1'b0;
end

endmodule
