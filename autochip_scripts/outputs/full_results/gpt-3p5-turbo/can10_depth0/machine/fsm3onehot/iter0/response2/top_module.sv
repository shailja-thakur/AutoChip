module top_module (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);

  // Assign statements
  assign next_state[0] = (in == 0) ? (state[0] | state[2]) : 0;
  assign next_state[1] = (in == 0) ? 0 : (state[0] | state[1] | state[3]);
  assign next_state[2] = (in == 0) ? (state[1] | state[3]) : 0;
  assign next_state[3] = (in == 0) ? 0 : state[2];
  assign out = state[3];

endmodule
