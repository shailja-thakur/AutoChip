module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] q_next;

  always @(posedge clk) begin
    if (reset)
      q <= 32'h1;
    else
      q <= q_next;
  end

  always @(posedge clk) begin
    q_next[31:1] <= {q[30:0], q[31] ^ q[1] ^ q[21]};
    q_next[0] <= q[31] ^ q[1] ^ q[21];
  end

endmodule
