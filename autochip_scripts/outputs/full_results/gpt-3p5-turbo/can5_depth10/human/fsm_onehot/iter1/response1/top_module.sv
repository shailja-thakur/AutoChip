module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);

  // Define internal wires/regs
  wire S0, S1, S2, S3, S4, S5, S6, S7, S8, S9;
  
  // Assign next_state[9:0] based on state[9:0] and in
  assign next_state[0] = (~state[0] & ~state[1] & ~state[2] & ~state[3]);
  assign next_state[1] = (~state[0] & ~state[1] & ~state[2] & state[3] & in) | (~state[1] & ~state[2] & ~state[3] & in);
  assign next_state[2] = (~state[0] & state[1] & ~state[2]) | (state[1] & ~state[2] & ~state[3] & in);
  assign next_state[3] = state[2] & ~state[3] & ~in;
  assign next_state[4] = state[0] & (~state[4] & ~state[5] & ~state[6] & ~state[7]);
  assign next_state[5] = (~state[0] & state[4]) | (state[4] & ~state[5] & ~state[6] & ~state[7]);
  assign next_state[6] = state[5] & ~state[6];
  assign next_state[7] = state[6] & ~state[7];
  assign next_state[8] = state[7] & ~state[8];
  assign next_state[9] = state[6] & state[9] & ~in;
  
  // Assign out1
  assign out1 = S1;
  
  // Assign out2
  assign out2 = S9;
  
endmodule
