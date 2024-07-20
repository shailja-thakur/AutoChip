module top_module(
  input in,
  output reg out);

  always @ (in) begin
    out <= in;  // Assigning the output port to the value of the input port
  end

endmodule
