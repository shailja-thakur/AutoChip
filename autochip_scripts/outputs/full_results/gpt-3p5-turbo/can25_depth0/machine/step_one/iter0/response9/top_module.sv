module top_module(
  output reg one); // added 'reg' to declare a reg variable

always @(*) // added sensitivity list
begin
  one = 1'b1; // assign value to 'one'
end

endmodule
