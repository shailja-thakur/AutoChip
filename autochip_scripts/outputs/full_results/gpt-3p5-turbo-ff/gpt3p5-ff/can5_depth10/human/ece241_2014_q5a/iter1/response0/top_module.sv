module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);
  
  reg [31:0] sum;
  wire [31:0] neg_x;

  assign neg_x = ~x + 1;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      sum <= 0;
      z <= 0;
    end else if (!areset && !z) begin
      sum <= sum + x;
      z <= sum;
    end else begin
      sum <= sum + neg_x;
      z <= sum;
    end
  end
endmodule
