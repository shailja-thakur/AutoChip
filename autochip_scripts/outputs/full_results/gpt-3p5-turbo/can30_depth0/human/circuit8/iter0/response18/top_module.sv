module top_module (
  input clock,
  input a, 
  output reg p,
  output reg q
);

reg a_ff, q_ff;

always @(posedge clock) begin
  a_ff <= a;
end

always @(posedge clock) begin
  if (a_ff) begin
    p <= 1'b1;
  end else begin
    p <= 1'b0;
  end
end

always @(posedge clock) begin
  if (a_ff) begin
    q_ff <= 1'b1;
  end else begin
    q_ff <= 1'b0;
  end
end

assign q = q_ff;

endmodule
