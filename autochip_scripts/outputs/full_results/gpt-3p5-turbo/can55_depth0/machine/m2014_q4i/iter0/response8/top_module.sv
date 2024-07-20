module top_module(
  output reg out
);

  // Assigning the output port to a constant value of 0
  always @(*) begin
    out = 0;
  end

endmodule
