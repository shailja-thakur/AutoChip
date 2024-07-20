module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;

  always @(posedge clk or posedge reset) begin
    if (reset)
      next_q <= 32'h1;
    else begin
      next_q[0] <= q[31] ^ q[21] ^ q[1] ^ q[0];
      next_q[1] <= q[0];
      next_q[2] <= q[1];
      next_q[3:31] <= q[2:30];
    end
  end

  always @(posedge clk) begin
    if (reset)
      q <= 32'h1;
    else
      q <= next_q;
  end

endmodule
