module top_module(
    input clk,
    input d,
    output reg q);
  
  // Initial value of q set to unknown or undefined (1'bx)
  initial begin
    q = 1'bx;
  end
  
  // Synchronizing data signal d with clock signal clk
  always @(posedge clk) begin
    q <= d;
  end
  
endmodule
