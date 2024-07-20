module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg q_next;

  always @(posedge clk) begin
    if (E) begin
      if (L)
        q_next <= R;
      else
        q_next <= w;
    end
    else
      q_next <= Q;
  end

  always @(posedge clk) begin
    Q <= q_next;
  end

endmodule
