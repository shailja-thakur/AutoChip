module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);

  // Define internal wires/regs
  wire S0, S1, S2, S3, S4, S5, S6, S7, S8, S9;

  // Assign next_state[9:0] based on state[9:0] and in
  assign next_state = {state[5] & ~in, state[1] | state[3] & ~in, 
                      state[2] & ~in, state[6] | state[9] & ~in, 
                      state[0] | state[4] & ~in, state[8] & in, 
                      1'b0, state[7] & in, 
                      state[0] | state[5], state[4], state[2]};

  // Assign out1
  assign out1 = S7;

  // Assign out2
  assign out2 = S9;

endmodule
