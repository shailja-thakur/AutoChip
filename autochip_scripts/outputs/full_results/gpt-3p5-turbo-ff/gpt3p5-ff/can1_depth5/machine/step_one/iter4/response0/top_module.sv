module top_module(
    input wire clk,
    output reg one);
  
  always @(posedge clk) begin
    one <= 1'b1;
  end
  
endmodule
