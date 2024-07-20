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
    end else if (x) begin
      sum <= sum - 1;
      z <= sum;
    end else begin
      sum <= sum + 1;
      z <= sum;
    end
  end
endmodule
