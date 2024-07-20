module top_module(
  output reg zero); // Added "reg" datatype for the output

  always @(posedge clk) // Added a clock signal
    zero <= 0; // Assigning the output zero to 0

endmodule
