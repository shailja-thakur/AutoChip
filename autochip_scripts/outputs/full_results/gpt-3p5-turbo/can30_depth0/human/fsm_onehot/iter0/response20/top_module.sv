module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);

  // Implementing the state transition logic
  always @* begin
    case(state)
      10'b1_0000_0000: next_state = 10'b1_0000_0000;    // S0 (0, 0) --0--> S0
      10'b1_0000_0000: next_state = 10'b1_0000_0001;    // S0 (0, 0) --1--> S1
      10'b1_0000_0001: next_state = 10'b1_0000_0000;    // S1 (0, 0) --0--> S0
      10'b1_0000_0001: next_state = 10'b1_0000_0010;    // S1 (0, 0) --1--> S2
      10'b1_0000_0010: next_state = 10'b1_0000_0000;    // S2 (0, 0) --0--> S0
      10'b1_0000_0010: next_state = 10'b1_0000_0011;    // S2 (0, 0) --1--> S3
      10'b1_0000_0011: next_state = 10'b1_0000_0000;    // S3 (0, 0) --0--> S0
      10'b1_0000_0011: next_state = 10'b1_0000_0100;    // S3 (0, 0) --1--> S4
      10'b1_0000_0100: next_state = 10'b1_0000_0000;    // S4 (0, 0) --0--> S0
      10'b1_0000_0100: next_state = 10'b1_0000_0101;    // S4 (0, 0) --1--> S5
      10'b1_0000_0101: next_state = 10'b1_0000_1000;    // S5 (0, 0) --0--> S8
      10'b1_0000_0101: next_state = 10'b1_0000_0110;    // S5 (0, 0) --1--> S6
      10'b1_0000_0110: next_state = 10'b1_0000_1001;    // S6 (0, 0) --0--> S9
      10'b1_0000_0110: next_state = 10'b1_0000_0111;    // S6 (0, 0) --1--> S7
      10'b1_0000_0111: next_state = 10'b1_0000_0000;    // S7 (0, 1) --0--> S0
      10'b1_0000_0111: next_state = 10'b1_0000_0111;    // S7 (0, 1) --1--> S7
      10'b1_0000_1000: next_state = 10'b1_0000_0000;    // S8 (1, 0) --0--> S0
      10'b1_0000_1000: next_state = 10'b1_0000_0001;    // S8 (1, 0) --1--> S1
      10'b1_0000_1001: next_state = 10'b1_0000_0000;    // S9 (1, 1) --0--> S0
      10'b1_0000_1001: next_state = 10'b1_0000_0001;    // S9 (1, 1) --1--> S1
      default: next_state = 10'b1_0000_0000;
    endcase
  end

  // Implementing the output logic
  assign out1 = (state == 10'b1_0000_0111) ? 1'b1 : 1'b0;    // S7 (0, 1) has out1 = 1
  assign out2 = (state == 10'b1_0000_1000) ? 1'b1 : 1'b0;    // S8 (1, 0) has out2 = 1

endmodule
