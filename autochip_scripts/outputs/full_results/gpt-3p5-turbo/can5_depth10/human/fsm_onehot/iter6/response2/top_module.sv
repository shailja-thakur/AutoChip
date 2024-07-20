module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);

  // Define internal wires/regs
  reg [9:0] next;

  // Assign next_state[9:0] based on state[9:0] and in
  always @ (*) begin
    case(state)
      10'b0000000001: next = (in) ? 10'b0010000000 : 10'b0000000010; // S0 (0, 0) --0--> S0, (0, 0) --1--> S1
      10'b0000000010: next = (in) ? 10'b1000000000 : 10'b0000000010; // S1 (0, 0) --0--> S0, (0, 0) --1--> S2
      10'b0000000100: next = (in) ? 10'b0010000000 : 10'b0000000100; // S2 (0, 0) --0--> S0, (0, 0) --1--> S3
      10'b0000001000: next = (in) ? 10'b0000001000 : 10'b0000001000; // S3 (0, 0) --0--> S0, (0, 0) --1--> S4
      10'b0000010000: next = (in) ? 10'b0000001010 : 10'b0000010000; // S4 (0, 0) --0--> S0, (0, 0) --1--> S5
      10'b0001000000: next = (in) ? 10'b0001000000 : 10'b0001000000; // S5 (0, 0) --0--> S8, (0, 0) --1--> S6
      10'b0010000000: next = (in) ? 10'b0000000010 : 10'b0000010000; // S6 (0, 0) --0--> S9, (0, 0) --1--> S7
      10'b0100000000: next = (in) ? 10'b0000000010 : 10'b0000000001; // S7 (0, 1) --0--> S0, (0, 1) --1--> S7
      10'b0000000001: next = (in) ? 10'b1000000000 : 10'b0000000010; // S8 (1, 0) --0--> S0, (1, 0) --1--> S1
      10'b0000000001: next = (in) ? 10'b0000000010 : 10'b0000000010; // S9 (1, 1) --0--> S0, (1, 1) --1--> S1
      default: next = 10'b0000000000;
    endcase
  end

  // Assign next_state
  assign next_state = next;

  // Assign out1
  assign out1 = (state[8] == 1'b1) ? 1'b1 : 1'b0;

  // Assign out2
  assign out2 = (state[7] == 1'b1) ? 1'b1 : 1'b0;

endmodule
