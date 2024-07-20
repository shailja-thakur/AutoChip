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
      10'b0000000001: next = 10'b0000000010; // S0 (0, 0) --0--> S7 (corrected)
      10'b0000000001: next = 10'b1000000000; // S0 (0, 0) --1--> S1
      10'b1000000000: next = 10'b0000000001; // S1 (0, 0) --0--> S0
      10'b1000000000: next = 10'b0010000000; // S1 (0, 0) --1--> S2
      10'b0010000000: next = 10'b0000100000; // S2 (0, 0) --0--> S3
      10'b0010000000: next = 10'b0000010000; // S2 (0, 0) --1--> S4 (corrected)
      10'b0000100000: next = 10'b0000001000; // S3 (0, 0) --0--> S4
      10'b0000100000: next = 10'b0000100010; // S3 (0, 0) --1--> S7 (corrected)
      10'b0000001000: next = 10'b0000001010; // S4 (0, 0) --0--> S5
      10'b0000001000: next = 10'b0000001000; // S4 (0, 0) --1--> S4
      10'b0000001010: next = 10'b0100000000; // S5 (0, 0) --0--> S8
      10'b0000001010: next = 10'b0001000000; // S5 (0, 0) --1--> S6
      10'b0001000000: next = 10'b0100000000; // S6 (0, 0) --0--> S8
      10'b0001000000: next = 10'b0000000010; // S6 (0, 0) --1--> S7
      10'b0000000010: next = 10'b0000000001; // S7 (0, 1) --0--> S0
      10'b0000000010: next = 10'b0000000010; // S7 (0, 1) --1--> S7
      10'b0100000000: next = 10'b0000000001; // S8 (1, 0) --0--> S0
      10'b0100000000: next = 10'b0000000001; // S8 (1, 0) --1--> S0 (corrected)
      10'b0100000000: next = 10'b0000000001; // S9 (1, 1) --0--> S0
      10'b0100000000: next = 10'b0000000010; // S9 (1, 1) --1--> S7 (corrected)
      default: next = 10'b0000000000; // Default case added to avoid latches
    endcase
  end
  
  // Assign next_state
  assign next_state = next;
  
  // Assign out1
  assign out1 = (state == 10'b0000001010) ? 1'b1 : 1'b0; // Corrected condition
  
  // Assign out2
  assign out2 = (state == 10'b0000000010) ? 1'b1 : 1'b0; // Corrected condition
  
endmodule
