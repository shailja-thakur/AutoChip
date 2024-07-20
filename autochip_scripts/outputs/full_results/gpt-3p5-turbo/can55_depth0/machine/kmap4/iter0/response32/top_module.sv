module top_module (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

always @* begin
  case ({a, b, c, d})
    //{4'b0000}: out = 1'b0;   // Example case statement to map input combinations to output
    //{4'b1111}: out = 1'b1;
    //{4'b0101}: out = 1'b0;
    default: out = 1'b0;       // Default case for any other combination of inputs
  endcase
end

endmodule
