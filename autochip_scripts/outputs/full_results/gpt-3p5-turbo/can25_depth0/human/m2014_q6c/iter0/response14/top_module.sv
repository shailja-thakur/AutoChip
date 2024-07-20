module top_module (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

  // Specify the states
  parameter A = 6'b000001;
  parameter B = 6'b000010;
  parameter C = 6'b000100;
  parameter D = 6'b001000;
  parameter E = 6'b010000;
  parameter F = 6'b100000;

  // Declare internal signals
  wire A_next, B_next, C_next, D_next, E_next, F_next;

  // Next-state logic
  assign A_next = (!y[1] && w) ? B : A;
  assign B_next = (y[1] && !y[2] && !w) ? C : D;
  assign C_next = (!y[3] && w) ? E : D;
  assign D_next = (y[3] && !w) ? F : A;
  assign E_next = (y[4] && !y[1] && !y[3]) ? E : D;
  assign F_next = (y[5] && !w) ? C : D;

  // Output signals
  assign Y2 = B_next;
  assign Y4 = E_next;

endmodule
