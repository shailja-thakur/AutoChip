module top_module(
  output reg zero // Declare zero as a reg type
);

  // Assign the output zero to 0
  always @(*) begin
    zero = 0;
  end

endmodule
