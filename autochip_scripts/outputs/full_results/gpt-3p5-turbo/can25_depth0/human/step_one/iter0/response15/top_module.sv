module top_module(
    output reg one);

  always @(posedge clk) begin
    one <= 1;
  end
  
endmodule
