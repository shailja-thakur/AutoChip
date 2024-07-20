module top_module(
    output reg out);   // Added reg keyword for output declaration

  always @(0)         // Sensitivity list is not required as there are no inputs
    out <= 0;         // Assigns 0 to the output

endmodule
