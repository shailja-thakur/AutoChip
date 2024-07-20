module top_module(
  input in,
  output reg out); // Added "reg" keyword to the output port declaration

always @(in) // Added sensitivity list for the always block
begin
  out = in; // Assigning the value of the input port to the output port
end

endmodule
