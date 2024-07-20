module top_module (
  input clk,
  input in,
  input areset,
  output out
);
  
  reg [1:0] state;
  
  always @(posedge clk) begin
    if (areset) begin
      state <= 2'b00; // Reset to state A
    end else begin
      case(state)
        2'b00: // State A
          state <= (in) ? 2'b01 : 2'b00; // Next state B if input is 1, else next state A
        2'b01: // State B
          state <= (in) ? 2'b01 : 2'b10; // Next state B if input is 1, else next state C
        2'b10: // State C
          state <= (in) ? 2'b11 : 2'b00; // Next state D if input is 1, else next state A
        2'b11: // State D
          state <= (in) ? 2'b01 : 2'b10; // Next state B if input is 1, else next state C
      endcase
    end
  end
  
  assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Set out to 1 when state is D
  
endmodule
