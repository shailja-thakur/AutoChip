module top_module(     
  input in,
  output reg out
);

  always @* begin
    out = ~in;
  end

endmodule
