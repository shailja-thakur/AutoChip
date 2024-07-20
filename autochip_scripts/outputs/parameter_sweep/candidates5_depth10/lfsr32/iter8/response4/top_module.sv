module top_module(
  input clk,
  input reset,
  output reg [31:0] q
);

  reg [1:0] feedback;
  reg [31:0] next_q;

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 32'h1;
    else begin
      feedback[0] <= q[0] ^ q[1];
      feedback[1] <= q[21] ^ q[22] ^ q[31];
      next_q[0] <= feedback[0];
      next_q[1:31] <= q[0:30];
      q <= next_q;
    end
  end

endmodule
