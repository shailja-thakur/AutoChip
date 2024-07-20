module top_module (
  input clk,
  input in,
  input areset,
  output reg out
);

  reg [1:0] state;

  always @(posedge clk) begin
    if (areset)
      state <= 2'b00; // Reset to state A
    else begin
      case (state)
        2'b00: // State A
          state <= in ? 2'b01 : 2'b00; // Next state: B if input is 1, A if input is 0
        2'b01: // State B
          state <= in ? 2'b01 : 2'b10; // Next state: B if input is 1, C if input is 0
        2'b10: // State C
          state <= in ? 2'b11 : 2'b00; // Next state: D if input is 1, A if input is 0
        2'b11: // State D
          state <= in ? 2'b01 : 2'b10; // Next state: B if input is 1, C if input is 0
      endcase
    end
  end

  always @(state) begin
    out = (state == 2'b11); // Output is 1 when state is D
  end
  
endmodule
