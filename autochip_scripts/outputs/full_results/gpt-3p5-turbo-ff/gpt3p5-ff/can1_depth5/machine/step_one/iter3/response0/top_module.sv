module top_module(
    input clk,
    output reg one);
  
  always @(posedge clk) begin
    one <= 1'b1;
  end
  
endmodule
