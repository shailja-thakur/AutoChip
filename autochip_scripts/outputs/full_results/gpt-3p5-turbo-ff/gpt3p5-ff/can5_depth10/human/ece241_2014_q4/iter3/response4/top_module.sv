module top_module (
  input clk,
  input x,
  output z
);

  reg x_reg=0;          // Flip-flop for input x
  reg xor_out_reg=0;    // Flip-flop for XOR output
  reg and_out_reg=0;    // Flip-flop for AND output
  reg or_out_reg=0;     // Flip-flop for OR output
  
  wire xor_in_wire;
  wire and_in_wire;
  wire or_in_wire;
  
  assign xor_in_wire = xor_out_reg;
  assign and_in_wire = ~and_out_reg;
  assign or_in_wire = ~or_out_reg;

  always @(posedge clk)
  begin
    x_reg <= x;
    xor_out_reg <= x_reg ^ xor_in_wire;     // XOR gate with flip-flop output
    and_out_reg <= x_reg & and_in_wire;    // AND gate with flip-flop complemented output
    or_out_reg <= x_reg | or_in_wire;      // OR gate with flip-flop complementary output
  end

  assign z = xor_out_reg ^ and_out_reg ^ or_out_reg; // XNOR gate with flip-flop outputs

endmodule
