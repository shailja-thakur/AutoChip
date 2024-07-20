module top_module(
  output reg one); // Added "reg" to specify that "one" is a register

  always @*     // Added "always @*" to make it a combinational always block
  begin
    one = 1'b1; // Assigning "one" to a constant value of 1'b1
  end

endmodule
