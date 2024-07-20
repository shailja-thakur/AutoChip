module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] feedback;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 1;
      feedback <= 0;
    end else begin
      feedback[4] <= q[2] ^ q[4];
      feedback[3] <= q[4] ^ feedback[4];
      feedback[2:0] <= q[3:1];
      q <= feedback;
    end
  end

endmodule
