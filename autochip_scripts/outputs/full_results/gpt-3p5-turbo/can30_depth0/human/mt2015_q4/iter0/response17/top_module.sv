module top_module(
  input x,
  input y,
  output z);

  // Submodule A instances
  A A1(x, y, z_A1);
  A A2(x, y, z_A2);

  // Submodule B instances
  B B1(x, y, z_B1);
  B B2(x, y, z_B2);

  // OR gate
  assign z_OR = z_A1 | z_B1;

  // AND gate
  assign z_AND = z_A2 & z_B2;

  // XOR gate
  assign z = z_OR ^ z_AND;
  
endmodule
module A(
  input x,
  input y,
  output z_A);
  
  assign z_A = (x ^ y) & x;
  
endmodule
module B(
  input x,
  input y,
  output z_B);
  
  // Simulation waveform
  reg [1:0] time = 0;
  reg [2:0] z_B_sim;
  
  always @(x, y) begin
    case (time)
      0: z_B_sim = 1;
      5: z_B_sim = 1;
      10: z_B_sim = 1;
      15: z_B_sim = 1;
      20: z_B_sim = 1;
      25: z_B_sim = 0;
      30: z_B_sim = 0;
      35: z_B_sim = 0;
      40: z_B_sim = 0;
      45: z_B_sim = 1;
      50: z_B_sim = 1;
      55: z_B_sim = 1;
      60: z_B_sim = 0;
      65: z_B_sim = 0;
      70: z_B_sim = 1;
      75: z_B_sim = 0;
      80: z_B_sim = 0;
      85: z_B_sim = 0;
      90: z_B_sim = 0;
    endcase
  end
  
  assign z_B = z_B_sim;
  
endmodule
