module top_module(
  input clk,
  input d,
  output reg q);
  
  reg q; // Register signal q
  
  always @(posedge clk) // Triggered by the rising edge of the clock signal
    q <= d; // Set register signal q to the value of the data signal d
    
  initial
    q = 1'hx; // Set initial value of register signal q to 1'hx, which is a hexadecimal representation of a one-bit unknown/undefined value

endmodule
