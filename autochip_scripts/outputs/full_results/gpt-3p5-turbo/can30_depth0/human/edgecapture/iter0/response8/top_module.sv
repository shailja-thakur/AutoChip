module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);

  reg [31:0] in_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      in_reg <= 0;
      out <= 0;
    end else begin
      in_reg <= in;
      out <= (in_reg & ~in) | (out & in);
    end
  end

endmodule
