module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

  reg p_next, q_next;

  always @(posedge clock) begin
    if (a == 1'b1) begin
      p_next <= p ^ a;
      q_next <= p & ~q;
    end else begin
      p_next <= p;
      q_next <= q;
    end
  end

  always @(posedge clock) begin
    p <= p_next;
    q <= q_next;
  end

endmodule
