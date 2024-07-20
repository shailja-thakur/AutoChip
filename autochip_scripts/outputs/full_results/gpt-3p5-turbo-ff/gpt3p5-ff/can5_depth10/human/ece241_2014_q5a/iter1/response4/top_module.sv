module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

  reg [31:0] sum;
  reg [31:0] twos_complement;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      sum <= 0;
      z <= 0;
    end else begin
      sum <= sum + x;
      twos_complement <= sum + 1;
      if (x == 1'b1) begin
        z <= ~twos_complement + 1;
      end else begin
        z <= twos_complement;
      end
    end
  end
endmodule
