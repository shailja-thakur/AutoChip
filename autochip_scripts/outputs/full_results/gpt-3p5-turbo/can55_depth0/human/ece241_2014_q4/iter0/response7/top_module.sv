module top_module (
  input clk,
  input x,
  output reg z
);

  reg d0, d1, d2;
  
  always @(posedge clk) begin
    d0 <= x ^ d0; // XOR gate with input x and flip-flop d0 output
    d1 <= ~d1 & d1; // AND gate with complemented flip-flop d1 output and flip-flop d1 output
    d2 <= ~d2 | d2; // OR gate with complemented flip-flop d2 output and flip-flop d2 output

    z <= ~(d0 ^ d1 ^ d2); // Three-input XNOR gate with d0, d1, d2 outputs
  end

endmodule
