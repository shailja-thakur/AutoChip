module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);

  reg [9:0] next_state;

  always @(*)
    case (state)
      10'b0000000001: next_state = 10'b0000000001;
      10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000001;
      10'b0000000100: next_state = in ? 10'b0000000001 : 10'b0000001000;
      10'b0000001000: next_state = in ? 10'b0000000010 : 10'b0000010000;
      10'b0000010000: next_state = in ? 10'b0000000001 : 10'b0000100000;
      10'b0000100000: next_state = in ? 10'b0000000010 : 10'b0001000000;
      10'b0001000000: next_state = in ? 10'b0010000000 : 10'b0000000001;
      10'b0010000000: next_state = in ? 10'b0000000100 : 10'b0000000001;
      10'b0010000001: next_state = 10'b0000000001;
      10'b0010000010: next_state = in ? 10'b0000000100 : 10'b0000000001;
      default: next_state = 10'b0000000001;
    endcase

  assign out1 = (state == 10'b0000000111) ? 1'b0 : 1'b0;
  assign out2 = (state == 10'b0001000001 || state == 10'b0011000001) ? 1'b1 : 1'b0;
endmodule
