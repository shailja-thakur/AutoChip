module top_module(
  input clk,
  input reset,
  output reg [3:1] ena,
  output reg [15:0] q);

  reg [3:0] q0, q1, q2, q3; // individual digit outputs

  always @(posedge clk or posedge reset) begin
    if (reset)
      begin
        q0 <= 0;
        q1 <= 0;
        q2 <= 0;
        q3 <= 0;
      end
    else
      begin
        q0 <= q[3:0] + 1;
        q1 <= (ena[1] && (q0 == 10)) ? q[7:4] + 1 : q[7:4];
        q2 <= (ena[2] && (q1 == 10)) ? q[11:8] + 1 : q[11:8];
        q3 <= (ena[3] && (q2 == 10)) ? q[15:12] + 1 : q[15:12];
      end
  end

  always @* begin
    q = {q3, q2, q1, q0};
  end

endmodule
