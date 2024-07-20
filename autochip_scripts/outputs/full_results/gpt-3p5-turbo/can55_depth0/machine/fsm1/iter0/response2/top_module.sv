module top_module (
  input clk,
  input in,
  input areset,
  output out
);
  reg [1:0] state, next_state;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b10; // reset to state B
    else
      state <= next_state;
  end
  
  always @(*) begin
    case (state)
      2'b00: next_state = in ? 2'b00 : 2'b01; // State A, in=1: remain in A, in=0: transition to B
      2'b01: next_state = in ? 2'b01 : 2'b00; // State B, in=1: remain in B, in=0: transition to A
      default: next_state = 2'b01; // default state is B
    endcase
  end
  
  assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Set out high when state is B, low otherwise
endmodule
