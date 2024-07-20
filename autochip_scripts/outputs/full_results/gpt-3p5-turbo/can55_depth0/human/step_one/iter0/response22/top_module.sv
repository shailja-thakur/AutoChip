module top_module(
  output reg one = 1
);
  
  always @(posedge clk) begin
    one <= 1;
  end
  
endmodule
