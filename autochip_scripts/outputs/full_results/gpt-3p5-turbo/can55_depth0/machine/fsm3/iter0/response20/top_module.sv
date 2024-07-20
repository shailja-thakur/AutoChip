module top_module (
  input clk,
  input in,
  input areset,
  output reg out
);

  reg [1:0] state; // 2-bit register to store the current state

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00; // reset state to A
    else begin
      case (state)
        2'b00: // state A
          if (in)
            state <= 2'b01; // next state is B
          else
            state <= 2'b00; // next state is A
        2'b01: // state B
          if (in)
            state <= 2'b01; // next state is B
          else
            state <= 2'b10; // next state is C
        2'b10: // state C
          if (in)
            state <= 2'b11; // next state is D
          else
            state <= 2'b00; // next state is A
        2'b11: // state D
          if (in)
            state <= 2'b01; // next state is B
          else
            state <= 2'b10; // next state is C
        default:
          state <= 2'b00; // reset state to A
      endcase
    end
  end

  assign out = (state == 2'b11); // set out to 1 when in state D

endmodule
