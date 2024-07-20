module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2
);
  
  // Output logic equations
  assign out1 = (state[7] & ~in) | (state[9] & state[6] & ~in);
  assign out2 = state[7] & in;

  // State transition logic equations
  always @*
    case(state)
      10'b0000000000: next_state = in ? 10'b0000000010 : 10'b0000000000;
      10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000000;
      10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000000;
      10'b0000001000: next_state = in ? 10'b0000000010 : 10'b0000000000;
      10'b0000000011: next_state = in ? 10'b0000000110 : 10'b0000000100;
      10'b0000000110: next_state = in ? 10'b0000001011 : 10'b0000001000;
      10'b0000001011: next_state = in ? 10'b0000000010 : 10'b0000000000;
      10'b0000001110: next_state = in ? 10'b0000000001 : 10'b0000000000;
      10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000000;
      10'b0000001100: next_state = in ? 10'b0000000001 : 10'b0000000011;
      default: next_state = 10'bxxxxxxxxxx;
    endcase

endmodule
