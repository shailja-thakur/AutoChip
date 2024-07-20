module top_module(
  input in,
  output reg out
);

always @(*) begin
  out = in;  // Assign the output port to the value of the input port
end

endmodule
