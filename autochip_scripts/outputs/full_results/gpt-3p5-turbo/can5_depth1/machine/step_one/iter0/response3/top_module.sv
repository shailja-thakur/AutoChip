module top_module(
  output reg one // corrected port declaration
);

  // assign constant value of 1 to 'one'
  always @(posedge clk) // added clock for synchronous assignment
    one <= 1'b1;

endmodule
