module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);

  // State transition logic
  always @* begin
    case (state)
      10'b0000000001: next_state = 10'b0000000001;
      10'b0000000010: next_state = 10'b0000000110;
      10'b0000000100: next_state = 10'b0000000001;
      10'b0000000110: next_state = 10'b0000001000;
      10'b0000001000: next_state = 10'b0000000001;
      10'b0000001010: next_state = 10'b0000010000;
      10'b0000001100: next_state = 10'b0000000001;
      10'b0000001110: next_state = 10'b0000100000;
      10'b0000010000: next_state = 10'b0000000001;
      10'b0000010010: next_state = 10'b0001000000;
      10'b0000010100: next_state = 10'b0100000000;
      10'b0000010110: next_state = 10'b1000000000;
      10'b0000011000: next_state = 10'b0000000001;
      default: next_state = 10'b0000000001;
    endcase
  end

  // Output logic
  assign out1 = (state == 10'b0000000111) ? 1'b0 : 1'b0;
  assign out2 = (state == 10'b0000001110 || state == 10'b0000010011) ? 1'b1 : 1'b0;

endmodule
