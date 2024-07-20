module top_module (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

  always @* begin  // Fix: Changed sensitivity list from @(*) to @*
    case ({a, b, c, d})
      4'b0000: out = 1'b0;
      4'b1111: out = 1'b1;
      default: out = 1'b1; // Fix: Changed default output to 1 instead of 0
    endcase
  end

endmodule
