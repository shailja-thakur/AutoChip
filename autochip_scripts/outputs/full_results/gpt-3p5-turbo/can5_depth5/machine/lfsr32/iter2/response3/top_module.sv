module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] q_next;

  always @(posedge clk or negedge reset) begin
    if (reset)
      q <= 32'h1;
    else
      q <= q_next;
  end

  always @(posedge clk or negedge reset) begin
    if (reset)
      q_next <= 32'h1;
    else begin
      q_next[31:1] <= q[30:0];
      q_next[0] <= q[31] ^ q[21] ^ q[1];
    end
  end

endmodule
