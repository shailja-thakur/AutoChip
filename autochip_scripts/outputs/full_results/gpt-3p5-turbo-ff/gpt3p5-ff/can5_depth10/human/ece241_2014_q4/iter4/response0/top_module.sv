module top_module (
  input clk,
  input x,
  output z
);

  reg x_reg=0;          // Flip-flop for input x
  reg xor_out_reg=0;    // Flip-flop for XOR output
  reg and_out_reg=0;    // Flip-flop for AND output
  reg or_out_reg=1;     // Flip-flop for OR output

  always @(posedge clk)
  begin
    x_reg <= x;
    xor_out_reg <= x_reg ^ xor_out_reg;     // XOR gate with flip-flop output
    and_out_reg <= x_reg & and_out_reg;    // AND gate with flip-flop complemented output
    or_out_reg <= x_reg | and_out_reg;      // OR gate with flip-flop complementary output
  end

  assign z = xor_out_reg ^ and_out_reg ^ or_out_reg; // XNOR gate with flip-flop outputs

endmodule
