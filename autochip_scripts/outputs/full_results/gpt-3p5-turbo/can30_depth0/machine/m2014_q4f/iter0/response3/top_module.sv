module top_module (
  input  in1,
  input  in2,
  output reg out
);

  always @(in1 or in2)
    begin
      out <= in1 && ~in2;
    end

endmodule
