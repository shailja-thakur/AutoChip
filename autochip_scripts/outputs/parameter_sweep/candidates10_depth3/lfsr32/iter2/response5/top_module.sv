module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  reg [31:0] next_q;

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 32'h1;
    else
      q <= next_q;
  end

  always @* begin
    next_q[31] = q[30]^q[20]^q[0]^q[31];
    next_q[30:0] = q[29:0];
  end

endmodule
