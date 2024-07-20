module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);
  
  reg [31:0] sum;
  reg [31:0] temp;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      sum <= 0;
      z <= 1'b0;
    end else if (x) begin
      temp <= x;
      sum <= temp + 1;
      z <= ~sum + 1;
    end
  end

endmodule
