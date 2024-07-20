module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

  reg q_next;
  
  always @(posedge clk) begin
    q <= q_next;
    state <= q;
    if (a && !b)
      q_next <= 0;
    else if (!a && b)
      q_next <= 1;
    else
      q_next <= q;
  end

endmodule
