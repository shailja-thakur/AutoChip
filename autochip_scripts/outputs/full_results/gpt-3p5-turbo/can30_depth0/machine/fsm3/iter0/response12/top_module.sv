module top_module (
  input clk,
  input in,
  input areset,
  output out
);

reg [1:0] state; // 2-bit register for state machine

always @(posedge clk or posedge areset) begin
  if (areset) begin // reset to state A
    state <= 2'b00; // A
  end else begin
    case (state)
      2'b00: // A
        state <= (in) ? 2'b01 : 2'b00; // transition to B or stay in A
      2'b01: // B
        state <= (in) ? 2'b01 : 2'b10; // transition to B or C
      2'b10: // C
        state <= (in) ? 2'b11 : 2'b00; // transition to D or A
      2'b11: // D
        state <= (in) ? 2'b01 : 2'b10; // transition to B or C
    endcase
  end
end

assign out = (state == 2'b11); // out is 1 when state is D

endmodule
