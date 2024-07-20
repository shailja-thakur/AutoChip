module top_module(
  input in,
  output reg out); // Adding 'reg' keyword to specify that 'out' is a register
    
  always @(*) // Combinationally assigning the output based on the input
  begin
    out = in;
  end
    
endmodule
