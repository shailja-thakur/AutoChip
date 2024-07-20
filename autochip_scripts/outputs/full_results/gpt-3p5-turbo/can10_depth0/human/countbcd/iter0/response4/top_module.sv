module top_module(
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q);

  always @(posedge clk) begin
    if (reset) begin
      q <= 16'b0000_0000_0000_0000;
      ena <= 3'b000;
    end
    else begin
      if (ena[1]) begin
        if (q[7:4] == 4'b1001)
          q[7:4] <= 4'b0000;
        else
          q[7:4] <= q[7:4] + 1;
      end
      if (ena[2]) begin
        if (q[11:8] == 4'b1001)
          q[11:8] <= 4'b0000;
        else
          q[11:8] <= q[11:8] + 1;
      end
      if (ena[3]) begin
        if (q[15:12] == 4'b1001)
          q[15:12] <= 4'b0000;
        else
          q[15:12] <= q[15:12] + 1;
      end
    end
  end

endmodule
