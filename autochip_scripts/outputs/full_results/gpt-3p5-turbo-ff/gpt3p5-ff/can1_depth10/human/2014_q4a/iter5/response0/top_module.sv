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
    q_next <= (L) ? R : (w & ~Q);
  end
  else begin
    q_next <= Q;
  end
end

always @(posedge clk) begin
  if (L) begin
    Q <= q_load;
  end
  else begin
    Q <= q_next;
  end
end

always @(posedge clk) begin
  q_load <= (L) ? R : (w & ~Q);
end

endmodule
