module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  reg [3:1] d;

  always @(posedge clk) begin
    if (reset) begin
      q <= 0;
      ena <= 0;
    end
    else begin
      if (ena[1])
        q[3:0] <= q[3:0] + 1;
      if (ena[2])
        q[7:4] <= q[7:4] + 1;
      if (ena[3])
        q[11:8] <= q[11:8] + 1;
    end
  end

  always @(*) begin
    if (reset)
      d = 0;
    else
      d = {ena[2], ena[1], ena[3]};
  end

  always @(posedge clk) begin
    ena <= d;
  end

endmodule
