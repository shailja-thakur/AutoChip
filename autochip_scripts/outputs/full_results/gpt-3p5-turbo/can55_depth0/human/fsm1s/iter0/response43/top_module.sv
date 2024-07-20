module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

  reg [1:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b10; // reset state B
    else begin
      case (state)
        2'b00: // state A
          if (in)
            state <= 2'b00; // remain in state A
          else
            state <= 2'b10; // transition to state B
        2'b10: // state B
          if (in)
            state <= 2'b10; // remain in state B
          else
            state <= 2'b00; // transition to state A
        default:
          state <= 2'b10; // default to reset state B
      endcase
    end
  end

  assign out = (state == 2'b10) ? 1'b1 : 1'b0; // output is 1 in state B, otherwise 0

endmodule
