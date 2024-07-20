module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);
  
  assign out1 = (state[7] & in) | (state[8] & ~in);
  assign out2 = state[6] & ~state[0];
  
  always @* begin
    case(state)
      10'b0000000001: next_state = 10'b0100000000;
      10'b0000000010: next_state = 10'b0010000000;
      10'b0000000011: next_state = 10'b0100000000;
      10'b0000000100: next_state = 10'b0010000000;
      10'b0000000101: next_state = 10'b0110000000;
      10'b0000000110: next_state = 10'b0010000000;
      10'b0000000111: next_state = 10'b0100000000;
      10'b0000001000: next_state = 10'b0010000000;
      10'b0000001001: next_state = 10'b0110000000;
      10'b0000001010: next_state = 10'b1100000000;
      10'b0000001011: next_state = 10'b1000000000;
      10'b0000001100: next_state = 10'b1000000000;
      10'b0000001101: next_state = 10'b1000000001;
      10'b0000001110: next_state = 10'b0100000000;
      10'b0000001111: next_state = 10'b0110000000;
    endcase
  end
endmodule
