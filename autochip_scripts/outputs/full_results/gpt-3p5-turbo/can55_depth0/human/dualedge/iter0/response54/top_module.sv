module top_module(
  input clk,
  input d,
  output reg q);

reg q1, q2;

always @(posedge clk) begin
  q1 <= q;
end

always @(negedge clk) begin
  q2 <= q1;
end

always @(posedge clk) begin
  q <= d;
end

assign q = q2;

endmodule
