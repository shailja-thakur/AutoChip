module top_module (
  input clock,
  input a, 
  output reg p,
  output reg q
);

always @(posedge clock) begin
  if (a)
    p <= a;
end

always @(negedge clock) begin
  q <= a;
end

endmodule
