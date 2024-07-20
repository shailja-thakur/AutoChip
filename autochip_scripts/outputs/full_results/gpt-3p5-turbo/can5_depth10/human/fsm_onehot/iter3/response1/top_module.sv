module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);
  
  // Define internal wires/regs
  wire S0, S1, S2, S3, S4, S5, S6, S7, S8, S9;
  
  // Assign next_state[9:0] based on state[9:0] and in
  assign next_state[0] = state[0];
  assign next_state[1] = state[0] & in | state[7] & in & ~in;
  assign next_state[2] = state[1] & ~in | state[5] & in & ~in;
  assign next_state[3] = state[1] & in;
  assign next_state[4] = state[2] & ~in | state[4] & in & ~in;
  assign next_state[5] = state[3] & in;
  assign next_state[6] = state[10] & in & ~in;
  assign next_state[7] = state[13] | state[6] & ~in;
  assign next_state[8] = state[6] & in;
  assign next_state[9] = state[7] & in | state[8] & in;
  
  // Assign out1
  assign out1 = state[7] & in & ~state[6];

  // Assign out2
  assign out2 = state[9] & in & ~state[6];
  
endmodule
