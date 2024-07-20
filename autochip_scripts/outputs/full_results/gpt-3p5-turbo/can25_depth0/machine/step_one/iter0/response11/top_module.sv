module top_module(
    output reg one); // added 'reg' datatype for output one

  always @(posedge clk) begin // added a clock signal for synchronous assignment
    one <= 1'b1; // assigned output one to a constant value of 1
  end

endmodule
