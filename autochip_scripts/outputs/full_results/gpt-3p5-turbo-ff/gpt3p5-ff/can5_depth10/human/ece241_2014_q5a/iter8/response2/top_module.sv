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
      if (x == 1'b1) begin
        twos_complement <= ~sum + 1;
        z <= twos_complement;
      end else begin
        twos_complement <= sum + 1;
        z <= ~twos_complement;
      end
    end
  end
endmodule
