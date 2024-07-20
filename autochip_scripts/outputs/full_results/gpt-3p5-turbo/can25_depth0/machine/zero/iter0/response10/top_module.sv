module top_module (
  output reg zero); // added `reg` keyword to allow assignment to `zero` output

  always @ (*) // asynchronous assignment
    zero = 0;

endmodule
