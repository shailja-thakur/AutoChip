module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

  reg [31:0] sum;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      sum <= 0;
      z <= 0;
    end else begin
      sum <= sum + x;
      if (areset == 1'b1) begin
        z <= 0;
      end else if (areset == 1'b0 && x == 1'b1) begin
        z <= ~sum + 1;
      end else begin
        z <= sum;
      end
    end
  end
endmodule
