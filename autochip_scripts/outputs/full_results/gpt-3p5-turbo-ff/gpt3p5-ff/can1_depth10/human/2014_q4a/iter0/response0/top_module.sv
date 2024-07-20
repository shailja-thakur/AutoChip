module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

reg q_next;
reg q_load;

always @(posedge clk) begin
  if (E) begin
    Q <= q_next;
    q_next <= (L) ? R : (w & ~q_next);
  end
  else begin
    Q <= q_next;
    q_next <= Q;
  end
end

endmodule
