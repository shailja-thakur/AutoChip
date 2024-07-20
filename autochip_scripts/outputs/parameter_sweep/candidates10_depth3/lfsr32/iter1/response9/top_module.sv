module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] q_next; // Next state of the shift register

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 32'h1;
    else
      q <= q_next;
  end

  always @* begin
    q_next[31] = q[30]^q[20]^q[0];
    q_next[30:1] = q[31:2];
  end

endmodule
