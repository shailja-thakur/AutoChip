module top_module (
  input clock,
  input a, 
  output reg p,
  output reg q
);

reg a_prev;
always @(posedge clock) begin
  a_prev <= a;
  if (a && clock)
    p <= a_prev;
end

always @(negedge clock) begin
  q <= a;
end

endmodule
