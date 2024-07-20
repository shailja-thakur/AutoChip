module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

reg d;

always @(posedge clk) begin
  d <= a & b;
  state <= d;
end

always @(posedge clk) begin
  q <= state;
end

endmodule
