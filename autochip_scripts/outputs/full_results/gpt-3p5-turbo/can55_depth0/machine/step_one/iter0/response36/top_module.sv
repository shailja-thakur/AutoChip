module top_module(
  output reg one);  // Added reg datatype declaration for "one" output

  always @(posedge clk)   // Added a clock signal for sequential logic
  begin
    one <= 1'b1;   // Assign the value 1'b1 to "one" output
  end

endmodule
