module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);
  
  reg [31:0] sum;
  reg reset_prev;

  always @(posedge clk) begin
    if (areset) begin
      sum <= 0;
      z <= 0;
      reset_prev <= 1;
    end else if (reset_prev) begin
      sum <= 0;
      reset_prev <= 0;
    end else begin
      sum <= sum + x;
      z <= sum;
    end
  end
endmodule
