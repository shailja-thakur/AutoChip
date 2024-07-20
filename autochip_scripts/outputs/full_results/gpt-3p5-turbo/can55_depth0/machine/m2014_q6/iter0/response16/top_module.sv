module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  reg [2:0] state; // Define a 3-bit register for state
  always @(posedge clk or posedge reset) begin
    if (reset) // If reset is high, reset to state A
      state <= 3'b000; // State A
    else begin
      case (state) // Transition to the next state based on current state and input w
        3'b000: state <= w ? 3'b011 : 3'b000; // State B if w is low, state A if w is high
        3'b001: state <= w ? 3'b011 : 3'b010; // State D if w is high, state C if w is low
        3'b010: state <= w ? 3'b001 : 3'b010; // State D if w is high, state E if w is low
        3'b011: state <= w ? 3'b000 : 3'b101; // State A if w is high, state F if w is low
        3'b100: state <= w ? 3'b001 : 3'b100; // State D if w is high, state E if w is low
        3'b101: state <= w ? 3'b010 : 3'b101; // State C if w is high, state F if w is low
        default: state <= 3'b000; // Default to state A
      endcase
    end
  end

  assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0; // z is high in states E and F, low otherwise

endmodule
