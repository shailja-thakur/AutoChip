module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

  reg q_next;
  reg state_next;
  
  always @(posedge clk) begin
    q <= q_next;
    state <= state_next;
  end

  always @(a, b, state) begin
    q_next = a & ~state;
    state_next = b | state;
  end

endmodule
